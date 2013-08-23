require "area_select_cn/engine"

module AreaSelectCn
  autoload :DistrictController, 'area_select_cn/district_controller'
  autoload :Theme, 'area_select_cn/theme'

  module Helpers
    autoload :FormBuilderExtension, 'area_select_cn/helpers/form_builder_extension'
    autoload :FormBuilder, 'area_select_cn/helpers/form_builder'
  end

  begin
    require 'simple_form'
    require 'area_select_cn/hooks/simple_form'
  rescue LoadError
  end
end
require 'area_select_cn/selector'
require 'area_select_cn/area_select_ul_helper'
require 'area_select_cn/area_select_helper'

