require "bundler/gem_tasks"
require 'rubygems'
require 'rake'
require 'date'

desc "Run the tests"
task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.verbose = true
end

desc "Validate the gemspec"
task :gemspec do
  gemspec.validate
end
 
desc "Build gem locally"
task :build => :gemspec do
  system "gem build #{gemspec.name}.gemspec"
  FileUtils.mkdir_p "pkg"
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", "pkg"
end
 
desc "Install gem locally"
task :install => :build do
  system "gem install pkg/#{gemspec.name}-#{gemspec.version}"
end
