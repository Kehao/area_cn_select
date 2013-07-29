require "area_select_cn/engine"

module AreaSelectCn
  autoload :DistrictController, 'area_select_cn/district_controller'
  autoload :Id,                 'area_select_cn/id'
  autoload :Parser,             'area_select_cn/parser'
  autoload :District,           'area_select_cn/district'

  module Helpers
    autoload :FormBuilderExtension,'area_select_cn/helpers/form_builder_extension'
    autoload :FormBuilder,         'area_select_cn/helpers/form_builder'
    autoload :ToAreaSelectCnTag,   'area_select_cn/helpers/to_area_select_cn_tag'
  end

  mattr_reader :default_theme
  @@default_theme = {
    :select         => {:class=>"select-input"},
    :select_options => {:class=>"select-opts"},
    :select_prompt  => {:class=>"select-prompt"},
    :caret          => {:class=>"select-tangle"}
  }

  mattr_reader :bootstrap_theme
  @@bootstrap_theme= {
    :select         => {:class=>"btn-group"},
    :select_options => {:class=>"dropdown-menu"},
    :select_prompt  => {:class=>"dropdown-toggle"},
    :caret          => {:class=>"caret"}
  }

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

require "area_select_cn/action_view_ext"
