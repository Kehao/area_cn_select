# encoding: utf-8
module ActionView
  module Helpers
    module FormOptionsHelper
      def area_select_cn(object,method,region_code=nil,options={},html_options={})
        options.merge!(area_select_options(region_code))
        html_options = area_select_html_options(html_options)

        tag = InstanceTag.new(object, method, self, options.delete(:object))
        tag.to_area_select_cn_tag(region_code,options,html_options)
      end

      def area_select_html_options(html_options)
        theme = AreaSelectCn.public_send("#{html_options[:theme] || :default}_theme")

        if html_options[:theme].eql?(:bootstrap) && html_options[:prompt_class].nil?
          html_options[:prompt_class] = "btn"
        end

        theme.merge(html_options)
      end

      def area_select_options(region_code)
        options = {
          :selected_province  => nil,
          :selected_city      => nil,
          :selected_district  => nil,

          :selected_provinces => [],
          :selected_cities    => [],
          :selected_districts => []
        }

        id = AreaSelectCn::District.id(region_code)
        if id 
          options[:selected_province] = id.province && [id.province_name, id.province_id]
          options[:selected_city]     = id.city && [id.city_name,id.city_id]
          options[:selected_district] = id.district && [id.district_name, id.district_id]

          options[:selected_provinces] = id.selected_provinces 
          options[:selected_cities]    = id.selected_cities 
          options[:selected_districts] = id.selected_districts 
        else
          options[:selected_provinces] = AreaSelectCn::District.list_provinces
        end
        options
      end
    end

    class InstanceTag
      include AreaSelectCn::Helpers::ToAreaSelectCnTag 
    end

  end
end
