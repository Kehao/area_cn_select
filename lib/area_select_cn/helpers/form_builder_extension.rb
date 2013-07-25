# encoding: utf-8
module AreaSelectCn
  module Helpers
    module FormBuilderExtension
      def area_select(method,options={},html_options={})
        label = self.label method,:class=>"area-select-label"
        label + area_select_ul(method,options,html_options)
      end

      def area_select_ul(method,options={},html_options={})
        region_code = self.object.public_send(method)
        @template.area_select_ul(@object_name,method,
                                 region_code,objectify_options(options),html_options)
      end
    end
  end
end
