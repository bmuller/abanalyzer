# frozen_string_literal: true

require 'rake/testtask'
require 'bundler/gem_tasks'
require 'rdoc/task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

RDoc::Task.new('doc') do |rdoc|
  rdoc.title = 'ABAnalyzer - A/B test analysis library for Ruby'
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task default: %i[rubocop test]
