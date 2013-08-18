require "bayes_naive_jdp/version"

module BayesNaiveJdp
	class Classifier

		def initialize
			@custom_tokenizer = nil
			clear
		end

		def train(document, label)
			@training_set_size += 1
			label_seen(label)
			tokenize(document).each do |token|
				token_seen(token, label)
			end
		end

		def classify(document)
			tokens = tokenize(document)
			scores = {}
			
			@labels.each do |label, label_frequency|
				log_sum = 0		#	use logs to avoid floating point errors... underflow in particular
				tokens.each do |token|
					token_freq = @tokens[token].values.inject(0) { |sum, count| sum + count }
					if token_freq > 0
						token_prob = @tokens[token][label].to_f / label_frequency
						token_inverse_prob = (token_freq - @tokens[token][label]).to_f / (@training_set_size - label_frequency)
						wordicity = token_prob / (token_prob + token_inverse_prob)
						
						#	pull harder toward neutral (0.5) if we have a small sample size 
						#	(by averaging adjustment_weight fake 0.5 scores and our actual scores)
						adjustment_weight = 1
						wordicity = (adjustment_weight * 0.5 + token_freq * wordicity) / (adjustment_weight + token_freq)

						#	avoid breaking log
						wordicity = 0.01 if wordicity == 0
						wordicity = 0.00 if wordicity == 1
						log_sum += Math.log(1 - wordicity) - Math.log(wordicity)
					end
				end
				scores[label] = 1 / (1 + Math.exp(log_sum));
			end

			winner = scores.max_by { |k, v| v }
			{ 
				:winner => {:classification => winner[0], :confidence => winner[1] },
				:all_scores => scores
			}
		end
		
		#	supply a custom tokenizer as a block: String => [String]
		def tokenizer(&block)
			@custom_tokenizer = block
		end
		
		protected

		def clear
			@labels = Hash.new(0)
			@tokens = Hash.new({})
			@training_set_size = 0
		end

		def tokenize(document)
			return @custom_tokenizer.call(document) if @custom_tokenizer && @custom_tokenizer.lambda?
				
			#	default tokenizer: strip punctuation, splits words, and take unique occurrences
			document.downcase.gsub(/[^a-zA-Z 0-9]/, '').split(' ').uniq
		end

		def label_seen(label)
			@labels[label] += 1
		end

		def token_seen(token, label)
			@tokens[token] = Hash.new(0) unless @tokens.has_key? token
			@tokens[token][label] += 1
		end
	end
end
