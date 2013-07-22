require "area_select_cn/engine"

module AreaSelectCn
  autoload :DistrictController, 'area_select_cn/district_controller'
  autoload :Id,                 'area_select_cn/id'
  autoload :Parser,             'area_select_cn/parser'
  autoload :District,           'area_select_cn/district'
  autoload :BuilderMethods,     'area_select_cn/builder_methods'
  autoload :FormBuilder,        'area_select_cn/form_builder'
  autoload :Helper,             'area_select_cn/helper'

  begin
    require 'simple_form'
    require 'area_select_cn/hooks/simple_form'
  rescue LoadError
  end

  #def self.include_helper(scope)
  #  ActiveSupport.on_load(:action_controller) do
  #    include scope::Helper if defined?(scope::Helper)
  #  end
  #end
end
