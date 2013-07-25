# encoding: utf-8
module AreaSelectCn
  module Helpers
    module FormBuilderExtension
      def area_select_cn(method,html_options={})
        label = self.label method,:class=>"area-label"
        label + area_select_cn_without_label(method,html_options)
      end

      def area_select_cn_without_label(method,html_options={})
        region_code = self.object.public_send(method)
        @template.area_select_cn(@object_name,method,region_code,objectify_options({}),html_options)
      end
    end
  end
end
