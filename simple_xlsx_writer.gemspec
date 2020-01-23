Gem::Specification.new do |s|
  s.name = 'simple_xlsx_writer'
  s.version = '0.5.4'
  s.author = 'Dee Zsombor'
  s.email = 'zsombor@primalgrasp.com'
  s.homepage = 'http://simplxlsxwriter.rubyforge.org'
  s.rubyforge_project = 'simple_xlsx_writer'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Just as the name says, simple writter for Office 2007+ Excel files'
  s.files = [Dir['{bin,lib}/**/*'], 'LICENSE', 'Rakefile'].flatten
  s.require_path = 'lib'
  s.test_files = [Dir['{test}/**/*test.rb'], 'test/test_helper.rb'].flatten
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md']
  s.add_dependency('fast_xs', '>= 0.7.3')
  s.add_dependency('rake')
  s.add_dependency('rubyzip', '>= 2.0.0')
  s.add_dependency('zeitwerk')
  s.add_dependency('zip-zip')


  s.add_development_dependency('test-unit')
  s.add_development_dependency('byebug')
end
