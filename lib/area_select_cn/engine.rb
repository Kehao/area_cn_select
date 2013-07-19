module AreaSelectCn
  class Engine < ::Rails::Engine
    initializer "area_select_cn.view_helpers" do
      ::ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, AreaSelectCn::Helper
      end
    end
  end
end

#config.generators do |g|
#  g.test_framework      :rspec,        :fixture => false
#  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
#  g.assets false
#  g.helper false
#end

