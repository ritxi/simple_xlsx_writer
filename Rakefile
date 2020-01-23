require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rubygems/package_task'

task :default => [:test]

Rake::TestTask.new do |test|
  test.libs       << "test"
  test.test_files =  Dir['test/**/*_test.rb'].sort
  test.verbose    =  true
end
spec = Gem::Specification.load('./simple_xlsx_writer.gemspec')
Gem::PackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end
