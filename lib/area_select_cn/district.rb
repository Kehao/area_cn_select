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

    def id(code)
      return nil if code.blank?
      Id.new(code)
    end

  end
end
