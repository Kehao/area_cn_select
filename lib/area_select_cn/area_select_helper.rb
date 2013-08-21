# encoding: utf-8
require 'action_view/helpers/tag_helper'
module ActionView
  module Helpers
    module FormOptionsHelper
      def district_select(object, method, region_code=nil, options={}, html_options={})
        tag = InstanceTag.new(object, method, self, options.delete(:object))
        tag.to_district_select_tag(region_code, options, html_options)
      end
    end

    class AreaCnSelector #:nodoc:
      include ActionView::Helpers::TagHelper
      attr_accessor :options, :html_options, :region_code
      def initialize(instance_tag, region_code, options = {}, html_options = {})
        @instance_tag = instance_tag
        @region_code = objectify_code(region_code)
        @options = options.dup.merge(area_options)
        @html_options = html_options.dup
      end

      def objectify_code(code)
        code.is_a?(AreaSelectCn::Id) && code || AreaSelectCn::Id.new(code)
      end

      def area_options
        region_code.as_options
      end

      def to_select(scope)
        control_group(scope)
        #select(scope)
      end

      def secure_random
        @secure_random ||= "area-select-#{SecureRandom.hex}"
      end

      def select(scope)
        hidden_field = @instance_tag.to_input_field_tag("hidden", :class => "select-value", :value => region_code.value.presence)

        body = [
          public_send("select_#{scope}"),
          hidden_field,
          javascript_tag
        ].join
        content_tag(:div, body.html_safe, :class => "#{secure_random}")
      end

      def javascript_tag
        ""
      end

      def select_district
        [:province, :city, :district].map do |scope|
          scope_select(scope, options, html_options)
        end.join
      end

      def control_group(scope)
        controls = @instance_tag.content_tag(:div, select(scope), :class => "controls")
        label = @instance_tag.to_label_tag(nil, :class => "control-label")
        content_tag(:div, [label, controls].join.html_safe, :class => "control-group area_select_ul")
      end

      def scope_select(scope,options,html_options)
        selected_scope = options["selected_#{scope}".intern]
        selected_scopes = options["selected_#{scope.to_s.pluralize}".intern]

        @instance_tag.to_select_tag(
          selected_scopes.unshift(blank_prompts[scope]),
          {:selected =>selected_scope[1]}.merge(options),
          html_options
        )
      end

      def blank_prompts
        {
          :province => ["省 份",""], 
          :city => ["城 市",""], 
          :district => ["区 县",""]
        }
      end
    end

    module SelectHelperInstanceTag
      def to_district_select_tag(region_code, options, html_options)
        AreaCnSelector.new(self, region_code, options, html_options).to_select(:district)
      end
    end

    class InstanceTag #:nodoc:
      include SelectHelperInstanceTag
    end

  end
end
