# encoding: utf-8
module AreaSelectCn
  class FormBuilder < ActionView::Helpers::FormBuilder  
    include BuilderMethods
  end
end

#  def skyeye_form_for(object, *args, &block)
#    options = args.extract_options!
#    simple_form_for(object, *(args << options.merge(:builder => Skyeye::FormBuilder)), &block)
#  end
