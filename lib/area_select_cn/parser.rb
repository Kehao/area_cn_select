module AreaSelectCn
  class Parser
    class << self
      def list 
        @list ||= parser
      end

      def list_provinces
        @list_provinces ||=
          list.map do |province_id,province_hash|
          [province_hash[:text],province_id]
          end
      end

      def parser 
        tmp = {}
        json_data["province"].each do |province|
          tmp[province["id"]] = {:text => province["text"],:children => {}}
        end

        json_data["city"].each do |city|
          city["id"] =~ (area_regular)
          province_id = $1.ljust(6, '0')
          if tmp[province_id]
            tmp[province_id][:children][city["id"]] = {:text => city["text"], :children => {}}
          end
        end

        json_data["district"].each do |district|
          district["id"] =~ (area_regular)
          province_id = $1.ljust(6, '0')
          city_id = "#{$1}#{$2}".ljust(6, '0')
          if tmp[province_id] && tmp[province_id][:children][city_id]
            tmp[province_id][:children][city_id][:children][district["id"]] = {:text => district["text"]}
          end
        end
        tmp
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
