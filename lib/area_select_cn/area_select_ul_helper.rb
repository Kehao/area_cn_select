# encoding: utf-8
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'
module ActionView
  module Helpers
    module FormOptionsHelper
      def district_select_ul(object, method, region_code=nil, options={}, html_options={})
        tag = InstanceTag.new(object, method, self, options.delete(:object))
        tag.to_district_select_ul_tag(region_code, options, html_options)
      end
      alias_method :area_select_ul, :district_select_ul

      def city_select_ul(object, method, region_code=nil, options={}, html_options={})
        tag = InstanceTag.new(object, method, self, options.delete(:object))
        tag.to_city_select_ul_tag(region_code, options, html_options)
      end

      def province_select_ul(object, method, region_code=nil, options={}, html_options={})
        tag = InstanceTag.new(object, method, self, options.delete(:object))
        tag.to_province_select_ul_tag(region_code, options, html_options)
      end
    end

    class AreaCnSelectUlSelector #:nodoc:
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      attr_accessor :options, :html_options, :region_code

      def initialize(instance_tag, region_code, options = {}, html_options = {})
        @instance_tag = instance_tag
        @region_code = objectify_code(region_code)
        @options = options.dup.merge(area_options).merge(theme_options(options))
        @html_options = html_options.dup
      end

      def objectify_code(code)
        code.is_a?(AreaSelectCn::Id) && code || AreaSelectCn::Id.new(code)
      end

      def area_options
        region_code.as_options
      end

      def theme_options(options)
        theme_options = theme[options[:theme]]
        theme_options ||= theme[:default]

        if options[:theme].eql?(:bootstrap) && options[:prompt_class].nil?
          theme_options[:prompt_class] = "btn"
        else
          theme_options[:prompt_class] = options[:prompt_class]
        end
        theme_options
      end

      def secure_random
        @secure_random ||= "area-select-#{SecureRandom.hex}"
      end

      def theme
        AreaSelectCn::Theme.area_select_ul
      end

      def javascript_tag
        javascript = <<-JAVASCRIPT
          <script>
            if(window.AREA_SELECT_CN_FIELDS === undefined) {
              window.AREA_SELECT_CN_FIELDS = [];
            }
            window.AREA_SELECT_CN_FIELDS.push(
              [".#{secure_random}",
                {
                  selectContainer:        '.#{options[:select][:class]}',
                  selectOptsContainer:    '.#{options[:select_options][:class]}',
                  selectPromptContainer:  '.#{options[:select_prompt][:class]}',
                  onChange: function($container,code){
                    $container.find(".select-value").val(code);
                  }
                }
              ]
            );
          </script>
        JAVASCRIPT
        javascript
      end

      def control_group(select_scope)
        controls = @instance_tag.content_tag(:div, select(select_scope), :class => "controls")
        label = @instance_tag.to_label_tag(nil, :class => "control-label")
        content_tag(:div, [label, controls].join.html_safe, :class => "control-group area_select_ul")
      end

      def to_select(select_scope)
        if options[:simple_form]
          select(select_scope)
        else
          control_group(select_scope)
        end
      end

      def select(select_scope)
        hidden_field = @instance_tag.to_input_field_tag("hidden", :class => "select-value", :value => region_code.value.presence)

        body = [
            hidden_field,
            public_send(select_scope),
            javascript_tag
        ].join
        content_tag(:div, body.html_safe, :class => "#{secure_random}")
      end

      def select_district
        [:province, :city, :district].map do |scope|
          scope_select(scope, options, html_options)
        end.join
      end

      def select_province
        scope_select(:province, options, html_options)
      end

      def select_city
        [:province, :city].map do |scope|
          scope_select(scope, options, html_options)
        end.join
      end

      def selected(cur, required, class_name="active")
        required = [required].flatten
        required.index(cur) && class_name
      end

      def blank_prompts
        {:province => "省 份", :city => "城 市", :district => "区 县"}
      end

      def scope_select(scope, options, html_options)
        selected_scope = options["selected_#{scope}".intern]
        selected_scopes = options["selected_#{scope.to_s.pluralize}".intern]

        pmt = ''
        data_value = selected_scope && {:value => selected_scope[1]} || {}
        data_text = selected_scope && selected_scope[0] || blank_prompts[scope]
        pmt << content_tag(:span, data_text, :class => "select-content", :data => data_value)
        pmt << content_tag(:span, "", options[:caret])

        opts = ''
        blank_link = link_to(blank_prompts[scope], "javascript:void(0);")
        opts << content_tag(:li, blank_link, :class => selected(selected_scope, nil), :data => {:value => ""})

        selected_scopes.each do |scope|
          scope_link = link_to scope[0], "javascript:void(0);"
          opts << content_tag(:li, scope_link, :class => selected(scope[1], selected_scope && selected_scope[1]), :data => {:value => scope[1]})
        end

        prompt_class = {
            :class => [options[:select_prompt][:class], options[:prompt_class]].join(" ")
        }
        prompt = link_to(pmt.html_safe, "javascript:void(0);", options[:select_prompt].merge(prompt_class))
        select_options = content_tag(:ul, opts.html_safe, options[:select_options].merge(:style => "max-height:350px;overflow:scroll"))

        select = prompt + select_options
        select_class = options[:select][:class]
        content_tag(:div, select, options[:select].merge(:class => [select_class, scope].join(" ")))
      end

    end

    module SelectUlHelperInstanceTag

      def to_district_select_ul_tag(region_code, options, html_options)
        AreaCnSelectUlSelector.new(self, region_code, options, html_options).to_select(:select_district)
      end

      def to_city_select_ul_tag(region_code, options, html_options)
        AreaCnSelectUlSelector.new(self, region_code, options, html_options).to_select(:select_city)
      end

      def to_province_select_ul_tag(region_code, options, html_options)
        AreaCnSelectUlSelector.new(self, region_code, options, html_options).to_select(:select_province)
      end
    end

    class InstanceTag #:nodoc:
      include SelectUlHelperInstanceTag
    end

  end
end

