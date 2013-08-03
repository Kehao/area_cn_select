module AreaSelectCn
  class Parser
    class << self
      def list 
        @list ||= parser[:list]
      end

      def areas
        @areas ||= parser[:areas]
      end

      def list_provinces
        @list_provinces ||=
          list.map do |province_id,province_hash|
          [province_hash[:text],province_id]
          end
      end

      def parser 
        list = {}
        areas= {}
        json_data["province"].each do |province|
          list[province["id"]] = {:text => province["text"],:children => {}}

          areas[province["id"]] = province["text"]
        end

        json_data["city"].each do |city|
          city["id"] =~ (area_regular)
          province_id = $1.ljust(6, '0')
          if list[province_id]
            list[province_id][:children][city["id"]] = {:text => city["text"], :children => {}}

            areas[city["id"]] = city["text"]
          end
        end

        json_data["district"].each do |district|
          district["id"] =~ (area_regular)
          province_id = $1.ljust(6, '0')
          city_id = "#{$1}#{$2}".ljust(6, '0')
          if list[province_id] && list[province_id][:children][city_id]
            list[province_id][:children][city_id][:children][district["id"]] = {:text => district["text"]}

            areas[district["id"]] = district["text"]
          end
        end
        {:list=>list,:areas=>areas}
      end

      def area_regular
        Id.id_regular
      end

      def json_data
        @json_data ||= JSON.parse(File.read(data_path))
      end

      def data_path
        "#{AreaSelectCn::Engine.root}/lib/areas.json"
      end
    end
  end
end
