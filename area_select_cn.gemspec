$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "area_select_cn/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "area_select_cn"
  s.version     = AreaSelectCn::VERSION
  s.authors     = ["kehao"]
  s.email       = ["kehao.qiu@gmail.com"]
  s.homepage    = "http://cnblogs.com/orez88"
  s.summary     = "AreaSelectCn."
  s.description = "AreaSelectCn."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'haml'

  #s.add_development_dependency 'spork', '~> 1.0rc'
  #s.add_development_dependency 'spork-rails'
  # s.add_dependency "jquery-rails"

end
