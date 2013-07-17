require "area_select_cn/engine"
require "area_select_cn/id"
require "area_select_cn/parser"
require "area_select_cn/district"
require "area_select_cn/form_builder"

module AreaSelectCn
  mattr_reader :area_regular
  @@area_regular = /(\d{2})(\d{2})(\d{2})/ 
end
