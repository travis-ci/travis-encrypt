# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'travis/encrypt/version'

Gem::Specification.new do |s|
  s.name         = "travis-encrypt"
  s.version      = Travis::Encrypt::VERSION
  s.authors      = ["Travis CI"]
  s.email        = "contact@travis-ci.org"
  s.homepage     = "https://github.com/travis-ci/travis-encrypt"
  s.summary      = "Travis CI encryption support"
  s.description  = "#{s.summary}."
  s.license      = "MIT"

  s.files        = Dir['{bin/**/*,lib/**/*,spec/**/*,[A-Z]*}']
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
end
