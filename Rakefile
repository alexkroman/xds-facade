require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

test_files_pattern = 'test/**/*_test.rb'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = test_files_pattern
  t.verbose = false
end

spec = Gem::Specification.new do |s| 
  s.name = "xds-facade"
  s.version = "0.1.0"
  s.author = "Project Laika"
  s.email = "dev@projectlaika.org"
  s.homepage = "http://projectlaika.org"
  s.platform = Gem::Platform::RUBY
  s.summary = "Simple interface for XDS for use with JRuby"
  s.files = FileList["lib/**/*"].to_a
  s.require_path = "lib"
  s.has_rdoc = true
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end