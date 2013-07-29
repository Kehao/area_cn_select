#encoding: utf-8
module AreaSelectCn
  class Id
    include SelectOptions
    attr_reader :id

    def area_name(mark="-")
      [province_name,city_name,district_name].compact.join(mark) 
    end
    
    def get_text
      get[:text]
    end
    alias_method :get_name,:get_text
    alias_method :name,:get_text

    def get_children
      get[:children]
    end
    alias_method :children,:get_children

    def get
      @get ||= province? && province
      @get ||= city? && city
      @get ||= district? && district
      @get
    end

    def province_name
      province && province[:text]
    end

    def city_name
      city && city[:text]
    end

    def district_name
      district && district[:text]
    end

    def initialize(id)
      @id = id.to_s
    end

    def segment_blank?(segment)
      segment != "00"
    end

    def province
      @province ||=
      province_id && self.class.data && self.class.data[province_id]
    end

    def city
      city_id && province && province[:children][city_id]
    end

    def district
      district_id && city && city[:children][district_id]
    end

    def province?
      !!(province_id && city_id.nil?)
    end

    def city?
      !!(province_id && city_id && district_id.nil?)
    end

    def district?
      !!(province_id && city_id && district_id)
    end

    def province_id
      @province_id ||= 
        if id_match && segment_blank?(id_match[1])
          id_match[1].ljust(6, '0')
        end
    end

    def city_id 
      @city_id ||= 
        if id_match && segment_blank?(id_match[2])
          "#{id_match[1]}#{id_match[2]}".ljust(6, '0')
        end
    end

    def district_id
      @district_id ||= 
        if id_match && segment_blank?(id_match[3])
          id
        end
    end

    def id_match 
      @id_match ||= @id.match(self.class.id_regular)
    end

    class << self
      def parser
        @parser ||= Parser
      end

      def data
        @data ||= parser.list
      end

      def id_regular
        /(\d{2})(\d{2})(\d{2})/ 
      end
    end
  end
end
