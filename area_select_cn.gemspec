# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "area_select_cn/version"

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
  s.license       = 'MIT'

  s.add_dependency "rails", "~> 3.2.13"
end
