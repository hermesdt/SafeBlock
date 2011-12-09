# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "safeblock/version"

Gem::Specification.new do |s|
  s.name        = 'safeblock'
  s.version     = SafeBlock::VERSION 
  s.summary     = "Protect your methods or your code blocks!"
  s.description = "The purpose of this gem is to it inside classes to protect methods, or protect some concrete piece of code!"
  s.authors     = ["Alvaro Duran Tovar"]
  s.email       = 'hermesdt@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'http://github.com/hermesdt/SafeBlock'
end
