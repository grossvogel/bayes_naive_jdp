require 'pathname'
require 'test/unit'

dir = Pathname.new File.expand_path(File.dirname(__FILE__))
require dir + '..' + 'lib' + 'bayes_naive_jdp'

DOCUMENT_PATH = dir + 'documents'
CONFIDENCE_MIN = 0.98

class AuthorClassificationTest < Test::Unit::TestCase
	def test_blog_author_classification
		authors = ['lippert','schneier','krugman']
		classifier = BayesNaiveJdp::Classifier.new
		authors.each do |author|
			4.times do |i|
				file = DOCUMENT_PATH.join("#{author}-#{i+1}")
				classifier.train(File.open(file).read, author)
			end
		end

		authors.each do |author|
			file = DOCUMENT_PATH.join("#{author}-5")
			answer = classifier.classify(File.open(file).read)
			assert_equal(answer[:winner][:classification],author)
			assert(answer[:winner][:confidence] >= CONFIDENCE_MIN)
		end
	end
end
