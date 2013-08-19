# BayesNaiveJdp

This is a very simple Naive Bayesian classifier, build just for fun.

I decided to use it as an example while learning to package ruby code.

The algorithm used here is not original, but an adaptation from Burak Kanber's 
[Machine Learning in Javascript](http://readable.cc/feed/view/34236/burak-kanber-s-blog) series.

	


## Installation

Add this line to your application's Gemfile:

    gem 'bayes_naive_jdp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bayes_naive_jdp

## Usage

	#	create an instance of the Classifier
	classifier = BayesNaiveJdp::Classifier.new
	
	#	Train the Classifier using many samples from each valid category
	#	documents are strings, categories are strings, symbols, or integers
	classifier.train(document_a_1, category_a)
	classifier.train(document_a_2, category_a)
	classifier.train(document_a_3, category_a)
	..
	classifier.train(document_b_1, category_b)
	classifier.train(document_b_2, category_b)
	classifier.train(document_b_3, category_b)
	..

	#	use the classifier to categorize an unknown document
	results = classifier.classify(mystery_document)
	category = results[:winner][:classification]
	confidence = results[:winner][:confidence]

	#	also, results[:all_scores] is a hash 
	#	with categories as indices and confidence levels as values

