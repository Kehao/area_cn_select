#encoding: utf-8
module AreaSelectCn
  module Helper
    def selected(cur,required,class_name="active")
      required = [required].flatten
      required.index(cur) && class_name 
    end

    def scope_prompts
      {
        :province => "省 份",
        :city => "城 市",
        :district => "区 县"
      }
    end
  end
end
