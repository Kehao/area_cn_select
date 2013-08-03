#encoding: utf-8
module AreaSelectCn
  module District
    module_function 
    def list_provinces
      Parser.list_provinces
    end

    def list
      Parser.list
    end

    def search(name,limit=10)
      results = []
      Parser.areas.each do |code,area_name|
        break if results.size.eql?(limit)

        if area_name =~ /#{name}/ 
          results << id(code)
        end
      end

      results
    end

    def id(code)
      return nil if code.blank?
      Id.new(code)
    end
  end
end
