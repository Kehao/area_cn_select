#require 'active_support/concern'
module AreaSelectCn
  module Hooks
    module SimpleFormBuilderExtension
      class AreaSelectCnInput < SimpleForm::Inputs::Base
        def input
          @builder.area_select_cn(attribute_name, input_html_options.extract!(:theme,:btn_class))
        end
      end
    end
  end
end

::SimpleForm::FormBuilder.send :include, AreaSelectCn::BuilderMethods
::SimpleForm::FormBuilder.send :include, 
  AreaSelectCn::Hooks::SimpleFormBuilderExtension




