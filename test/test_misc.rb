require 'pathname'
require 'test/unit'

dir = Pathname.new File.expand_path(File.dirname(__FILE__))
require dir + '..' + 'lib' + 'bayes_naive_jdp'

DOCUMENT_PATH = dir + 'documents'
CONFIDENCE_MIN = 0.98

class MiscTest < Test::Unit::TestCase
	def test_integer_categories
		categories = [1, 2, 3]
		classifier = BayesNaiveJdp::Classifier.new
		categories.each do |cat|
			4.times do |i|
				classifier.train("#{cat} " * i, cat)
			end
		end

		categories.each do |cat|
			answer = classifier.classify("#{cat} " * 5)
			assert_equal(answer[:winner][:classification], cat)
		end
	end

	def test_symbol_categories_
		categories = [:one, :two, :three]
		classifier = BayesNaiveJdp::Classifier.new
		categories.each do |cat|
			4.times do |i|
				classifier.train("#{cat.to_s} " * i, cat)
			end
		end

		categories.each do |cat|
			answer = classifier.classify("#{cat.to_s} " * 5)
			assert_equal(answer[:winner][:classification], cat)
		end
	end
end
