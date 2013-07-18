require "area_select_cn/helper"
module AreaSelectCn
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer "area_select_cn.view_helpers" do
      ActionView::Base.send :include, AreaSelectCn::Helper
    end
  end
end
