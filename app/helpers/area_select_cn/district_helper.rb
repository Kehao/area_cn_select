# encoding: utf-8
module AreaSelectCn
  module DistrictHelper

    def selected(cur,required,class_name="active")
      required = [required].flatten
      required.index(cur) && class_name 
    end

    def area_select_options(region_code,opts={})
      options = {
        :attr_name => "region_code",
        :selected_province  => nil,
        :selected_city      => nil,
        :selected_district  => nil,

        :selected_provinces => [],
        :selected_cities    => [],
        :selected_districts => []
      }.merge(opts)

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
