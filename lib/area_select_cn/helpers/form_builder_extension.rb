# encoding: utf-8
module AreaSelectCn
  module Helpers
    module FormBuilderExtension
      def area_select_cn(method,html_options={})
        region_code = self.object.public_send(method)
        @template.area_select_cn(@object_name,method,region_code,html_options)
       end
    end
  end
end
