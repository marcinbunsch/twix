Gem::Specification.new do |s| 
  s.name       = "twix"
  s.summary    = "Simple twitter client"  
  s.description= File.read(File.join(File.dirname(__FILE__), 'README'))
  s.requirements = 
      [ 'An installed dictionary (most Unix systems have one)' ]
  s.version     = "0.0.1"
  s.homepage    = 'http://github.com/cfx/twix'
  s.author      = "cfx"
  s.email       = "jozef@applicake.com"
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.8.7'
  s.files       = Dir['**/**']
  s.executables = Dir['bin/*'].map { |f| File.basename(f) }
  s.test_files  = Dir["test/test*.rb"]
  s.has_rdoc    = false
  s.add_dependency('oauth', '>= 0.4.1')
  s.add_dependency('json', '>= 1.4.3')
end