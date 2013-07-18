# -*- encoding: utf-8 -*-
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
  s.summary     = %{中国地区选择}
  s.description = %{中国地区选择}

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'haml'
end
