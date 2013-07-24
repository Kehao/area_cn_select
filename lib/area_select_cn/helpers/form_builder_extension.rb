# encoding: utf-8
module AreaSelectCn
  module Helpers
    module FormBuilderExtension
      def area_select_cn(method,options = {},html_options={})
        options.reverse_merge! area_select_options(self.object.public_send(method))

        html_options = merge_opts(html_options)

        @template.area_select_cn(@object_name,method,options,html_options)
       end
     
      def merge_opts(html_options)
        theme = public_send("#{html_options[:theme] || :default}_theme")

        tmp = {}
        theme.each do |key,value|
          tmp["#{key}_js_class".intern] = theme[key][:class]
        end
        theme.merge! tmp

        if html_options[:theme].eql?(:bootstrap) && html_options[:prompt_class].nil?
          html_options[:prompt_class] = "btn"
        end

        if prompt_class = html_options[:prompt_class] 
          orig_class = theme[:select_prompt][:class]  
          theme[:select_prompt][:class] = [orig_class,prompt_class].join(" ") 
        end
        theme
      end

      def default_theme
        {
          :select         => {:class=>"select-input"},
          :select_options => {:class=>"select-opts"},
          :select_prompt  => {:class=>"select-prompt"},
          :caret          => {:class=>"select-tangle"}
        }
      end

      def bootstrap_theme
        {
          :select         => {:class=>"btn-group"},
          :select_options => {:class=>"dropdown-menu"},
          :select_prompt  => {:class=>"dropdown-toggle"},
          :caret          => {:class=>"caret"}
        }
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
          options[:selected_provinces] = District.list_provinces
        end
        options
      end
    end
  end
end
#@template.render "area_select_cn/district_ul", 
#area_select_options(self.object.public_send(attr),options).merge(:f => self,:attr=>attr)

