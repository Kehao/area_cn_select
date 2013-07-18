module AreaSelectCn
  module Helper
    def selected(cur,required,class_name="active")
      required = [required].flatten
      required.index(cur) && class_name 
    end
  end
end
