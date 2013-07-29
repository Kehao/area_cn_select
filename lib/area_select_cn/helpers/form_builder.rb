# encoding: utf-8
module AreaSelectCn
  module Helpers
    class FormBuilder < ActionView::Helpers::FormBuilder  
      include FormBuilderExtension

      def district_select_ul(method,options={},html_options={})
        control_label = label method,:class=>"control-label"
        controls = @template.content_tag(:div,super,:class=>"controls clearfix")
        @template.content_tag(:div,control_label + controls,:class=>"control-group area_select_ul") 
      end

      def city_select_ul(method,options={},html_options={})
        control_label = label method,:class=>"control-label"
        controls = @template.content_tag(:div,super,:class=>"controls clearfix")
        @template.content_tag(:div,control_label + controls,:class=>"control-group area_select_ul")
      end

      def province_select_ul(method,options={},html_options={})
        control_label = label method,:class=>"control-label"
        controls = @template.content_tag(:div,super,:class=>"controls clearfix")
        @template.content_tag(:div,control_label + controls,:class=>"control-group area_select_ul")
      end

    end
  end
end

#  def skyeye_form_for(object, *args, &block)
#    options = args.extract_options!
#    simple_form_for(object, *(args << options.merge(:builder => Skyeye::FormBuilder)), &block)
#  end
