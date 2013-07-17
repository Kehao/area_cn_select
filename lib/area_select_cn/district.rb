#encoding: utf-8
module AreaSelectCn
  module District
    module_function 
    def list
      Parser.list
    end

    def get(code)
      return nil if id.blank?
      Id.new(code).get
    end

  end
end
