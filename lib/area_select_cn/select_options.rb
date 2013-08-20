#encoding: utf-8
module AreaSelectCn
  module SelectOptions
    extend ActiveSupport::Concern
    def as_options
      options = self.class.options
      options[:selected_province] = province && [province_name, province_id]
      options[:selected_city]     = city && [city_name,city_id]
      options[:selected_district] = district && [district_name, district_id]

      options[:selected_provinces] = selected_provinces 
      options[:selected_cities]    = selected_cities 
      options[:selected_districts] = selected_districts 
      options
    end

    def selected_provinces
      self.class.data.map do |province_id,province_hash|
        [province_hash[:text],province_id]
      end
    end

    def selected_cities
      return [] unless province
      province[:children].map do |city_id,city_hash|
        [city_hash[:text],city_id]
      end
    end

    def selected_districts
      return [] unless city 
      city[:children].map do |district_id,district_hash| 
        [district_hash[:text],district_id]
      end
    end

    module ClassMethods
      def options
        {
          :selected_province  => nil,
          :selected_city      => nil,
          :selected_district  => nil,
          :selected_provinces => [],
          :selected_cities    => [],
          :selected_districts => []
        }
      end
    end

  end
end
