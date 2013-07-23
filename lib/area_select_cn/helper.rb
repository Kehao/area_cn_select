#encoding: utf-8
module AreaSelectCn
  module Helper
    def selected(cur,required,class_name="active")
      required = [required].flatten
      required.index(cur) && class_name 
    end

    def theme_classes(theme)
      tmp = {
      :bootstrap => {
        :selectContainer => "btn-group",
        :selectOptsContainer => "dropdown-menu",
        :selectPromptContainer => "dropdown-toggle",
        :caret => "caret" },
      :default => {
        :selectContainer => "select-input",
        :selectOptsContainer => "select-opts",
        :selectPromptContainer => "select-prompt",
        :caret => "select-tangle" }
      } 
      tmp[theme] || tmp[:default]
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
