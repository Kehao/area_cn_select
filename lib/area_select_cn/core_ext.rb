# encoding: utf-8
module ActionView
  module Helpers
    module FormOptionsHelper
      def area_select_cn(object,method,options = {},html_options)
        tag = InstanceTag.new(object, method, self, options.delete(:object))
        tag.to_area_select_cn_tag(options,html_options)
      end
    end

    class InstanceTag
      include AreaSelectCn::Helpers::ToAreaSelectCnTag 
    end

  end
end
