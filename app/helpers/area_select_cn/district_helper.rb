# encoding: utf-8
module AreaSelectCn
  module DistrictHelper
    def selected(cur,required,class_name="active")
      required = [required].flatten
      required.index(cur) && class_name 
    end
  end
end
