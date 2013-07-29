# encoding: utf-8
require 'action_view/helpers/tag_helper'
module ActionView
  module Helpers
    module FormOptionsHelper 
      def area_select_ul(object,method,region_code=nil,options={},html_options={})
        options.merge!(area_select_ul_options(region_code))
        options.merge!(area_select_ul_theme_options(options))

        tag = InstanceTag.new(object, method, self, options.delete(:object))
        tag.to_area_select_ul_tag(region_code,options,html_options)
      end

      def area_select_ul_theme_options(options)
        theme_options = AreaSelectCn.public_send("#{options[:theme] || :default}_theme")
        if options[:theme].eql?(:bootstrap) && options[:prompt_class].nil?
          theme_options[:prompt_class] = "btn"
        else
          theme_options[:prompt_class] = options[:prompt_class]
        end
        theme_options
      end

      def area_select_ul_options(region_code)
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

    class AreaCnSelector #:nodoc:
      include ActionView::Helpers::TagHelper
      attr_accessor :options,:html_options,:region_code

      def initialize(template_object,region_code, options = {}, html_options = {})
        @options      = options.dup
        @html_options = html_options.dup
        @region_code  = region_code 
        @template_object = template_object
      end
      
      def select_area 
        [:province,:city,:district].map do |scope|
          scope_select(scope,options,html_options)
        end.join("").html_safe
      end

      def selected(cur,required,class_name="active")
        required = [required].flatten
        required.index(cur) && class_name 
      end 

      def blank_prompts 
        {:province => "省 份", :city => "城 市", :district => "区 县"}
      end

      def scope_select(scope,options,html_options)
        selected_scope  = options["selected_#{scope}".intern]
        selected_scopes = options["selected_#{scope.to_s.pluralize}".intern]

        pmt = ''
        data_value = selected_scope && {:value=>selected_scope[1]} || {}
        data_text =  selected_scope && selected_scope[0] || blank_prompts[scope]
        pmt << content_tag(:span,data_text,:class=>"select-content",:data => data_value)
        pmt << content_tag(:span,"",options[:caret])

        opts = '' 
        blank_link = @template_object.link_to(blank_prompts[scope],"javascript:void(0);")
        opts << content_tag(:li,blank_link,:class =>selected(selected_scope,nil), :data=>{:value => ""}) 

        selected_scopes.each do |scope|
          scope_link =  @template_object.link_to scope[0],"javascript:void(0);"
          opts << content_tag(:li,scope_link,:class =>selected(scope[1],selected_scope && selected_scope[1]),:data => {:value => scope[1]}) 
        end

        prompt_class = {
          :class=>[options[:select_prompt][:class],options[:prompt_class]].join(" ")
        }
        prompt = @template_object.link_to(pmt.html_safe,"javascript:void(0);",options[:select_prompt].merge(prompt_class)) 
        select_options = content_tag(:ul,opts.html_safe,options[:select_options].merge(:style=>"max-height:350px;overflow:scroll")) 

        select = prompt + select_options
        content_tag(:div,select,options[:select])
      end

    end

    module AreaHelperInstanceTag
      def to_area_select_ul_tag(region_code,options,html_options)
        random = "area-select-#{SecureRandom.hex}"
        body = to_input_field_tag("hidden",:class =>"select-value",:value=>region_code)
        body << AreaCnSelector.new(@template_object,region_code,options,html_options).select_area
        body = content_tag(:div,body,:class=>"area_select_ul #{random} clearfix")
        body << javascript_tag(random,options)
        body
      end

      def javascript_tag(random,opts)
        javascript = <<-JAVASCRIPT
          <script>
             jQuery.District(".#{random}",{
               selectContainer:        '.#{opts[:select][:class]}',
               selectOptsContainer:    '.#{opts[:select_options][:class]}',
               selectPromptContainer:  '.#{opts[:select_prompt][:class]}',
                 onChange: function($container,code){ 
                 $container.find(".select-value").val(code); }
            })
          </script>
        JAVASCRIPT
        javascript.html_safe
      end

    end

    class InstanceTag #:nodoc:
      include AreaHelperInstanceTag 
    end

  end
end

