#require 'active_support/concern'
module AreaSelectCn
  module Hooks
    module SimpleFormBuilderExtension
      class AreaSelectCnInput < SimpleForm::Inputs::Base
        def input
          html_options = input_html_options.extract!(:theme,:prompt_class)
          if SimpleForm.default_wrapper.eql?(:bootstrap) && html_options[:theme].nil?
            html_options.merge!(:theme => :bootstrap)
          end
          @builder.area_select_cn_without_label(attribute_name,html_options)
        end
      end
    end
  end
end

::SimpleForm::FormBuilder.send :include, AreaSelectCn::Helpers::FormBuilderExtension
::SimpleForm::FormBuilder.send :include, 
  AreaSelectCn::Hooks::SimpleFormBuilderExtension




