module AreaSelectCn
  class FormBuilder < ActionView::Helpers::FormBuilder  
    def area_select(options = {})
      @template.render "area_select_cn/area_select", options.merge(:f => self)
    end
  end
end

#  def skyeye_form_for(object, *args, &block)
#    options = args.extract_options!
#    simple_form_for(object, *(args << options.merge(:builder => Skyeye::FormBuilder)), &block)
#  end
