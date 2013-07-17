module Skyeye 
  class FormBuilder < SimpleForm::FormBuilder  
    def area_select(options = {})
      @template.render "shared/area_select", options.merge(:f => self)
    end
  end
end

module ApplicationHelper
  def skyeye_form_for(object, *args, &block)
    options = args.extract_options!
    simple_form_for(object, *(args << options.merge(:builder => Skyeye::FormBuilder)), &block)
  end

  def area_name(region_code)
    ancestors = District.code_chain(region_code)
    province = ancestors[1] && District.get(ancestors[1])
        city = ancestors[2] && District.get(ancestors[2])
      county = ancestors[3] && District.get(ancestors[3])
    [province,city,county].compact.join("-") 
  end

  def area_select_options(region_code)
    options = {
      :attr_name => "region_code",
      :selected_province  => nil,
      :selected_city      => nil,
      :selected_county    => nil,

      :selected_provinces => [],
      :selected_cities    => [],
      :selected_counties  => []
    }
    unless region_code.blank?
      ancestors = District.code_chain(region_code)
      list = District.code_chain_list(region_code)

      options[:selected_province] = ancestors[1] && [District.get(ancestors[1]), ancestors[1]]
      options[:selected_city]     = ancestors[2] && [District.get(ancestors[2]), ancestors[2]]
      options[:selected_county]   = ancestors[3] && [District.get(ancestors[3]), ancestors[3]]

      options[:selected_provinces] = list["provinces"]
      options[:selected_cities]    = list["cities"]
      options[:selected_counties]  = list["counties"]
    else
      options[:selected_provinces] = District.list
    end
    options
  end

end
