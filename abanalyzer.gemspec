# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'abanalyzer/version'
require 'date'
require 'English'

Gem::Specification.new do |s|
  s.name = 'abanalyzer'
  s.version = ABAnalyzer::VERSION
  s.authors = ['Brian Muller']
  s.license = 'GPL-3.0'
  s.date = Date.today.to_s
  s.summary = 'A/B test analysis library for Ruby'
  s.email = 'bamuller@gmail.com'
  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.homepage = 'https://github.com/bmuller/abanalyzer'
  s.require_paths = ['lib']
  s.add_development_dependency('minitest', '~> 5.14')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rubocop', '~> 0.81')
  s.add_dependency('statistics2', '= 0.54')
end
