#require 'active_support/concern'
module AreaSelectCn
  module Hooks
    module SimpleFormBuilderExtension
      class AreaSelectInput < SimpleForm::Inputs::Base
        def input
          opts = options.extract!(:theme,:prompt_class)
          if SimpleForm.default_wrapper.eql?(:bootstrap) && opts[:theme].nil?
            opts.merge!(:theme => :bootstrap)
          end
          @builder.area_select_ul(attribute_name,opts)
        end
      end
    end
  end
end

::SimpleForm::FormBuilder.send :include, AreaSelectCn::Helpers::FormBuilderExtension
::SimpleForm::FormBuilder.send :include, 
  AreaSelectCn::Hooks::SimpleFormBuilderExtension




