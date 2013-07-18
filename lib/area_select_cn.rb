module AreaSelectCn
  #def self.include_helper(scope)
  #  ActiveSupport.on_load(:action_controller) do
  #    include scope::Helper if defined?(scope::Helper)
  #  end
  #end
end

require "area_select_cn/district_controller"
require "area_select_cn/engine"
require "area_select_cn/id"
require "area_select_cn/parser"
require "area_select_cn/district"
require "area_select_cn/form_builder"
