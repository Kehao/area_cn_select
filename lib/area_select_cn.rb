require "area_select_cn/engine"

module AreaSelectCn
  autoload :DistrictController, 'area_select_cn/district_controller'
  autoload :SelectOptions,      'area_select_cn/select_options'
  autoload :Parser,             'area_select_cn/parser'
  autoload :District,           'area_select_cn/district'
  autoload :Id,                 'area_select_cn/id'

  module Helpers
    autoload :FormBuilderExtension,   'area_select_cn/helpers/form_builder_extension'
    autoload :FormBuilder,            'area_select_cn/helpers/form_builder'
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

end
require 'area_select_cn/area_cn_helper'
