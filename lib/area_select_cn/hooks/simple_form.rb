#require 'active_support/concern'
module AreaSelectCn
  module Hooks
    module SimpleFormBuilderExtension
      class AreaSelectCnInput < SimpleForm::Inputs::Base
        def input
          options = input_html_options.extract!(:theme,:btn_class)
          if SimpleForm.default_wrapper.eql?(:bootstrap) && options[:theme].nil?
            options.merge!(:theme => :bootstrap,:btn_class=> "btn")
          end
          @builder.area_select_cn(attribute_name,options)
        end
      end
    end
  end
end

::SimpleForm::FormBuilder.send :include, AreaSelectCn::BuilderMethods
::SimpleForm::FormBuilder.send :include, 
  AreaSelectCn::Hooks::SimpleFormBuilderExtension




