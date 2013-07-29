#require 'active_support/concern'
module AreaSelectCn
  module Hooks
    module SimpleFormBuilderExtension
      class AreaSelectBase < SimpleForm::Inputs::Base
        def scope_input(scope)
          opts = options.extract!(:theme,:prompt_class)
          if SimpleForm.default_wrapper.eql?(:bootstrap) && opts[:theme].nil?
            opts.merge!(:theme => :bootstrap)
          end
          @builder.public_send(scope,attribute_name,opts)
        end
      end

      class DistrictSelectUlInput < AreaSelectBase
        def input
          scope_input(:area_select_ul) 
        end
      end

      class AreaSelectInput < DistrictSelectUlInput

      end

      class CitySelectUlInput < AreaSelectBase
        def input
          scope_input(:city_select_ul) 
        end
      end
      class ProvinceSelectUlInput < AreaSelectBase
        def input
          scope_input(:province_select_ul) 
        end
      end

    end
  end
end

::SimpleForm::FormBuilder.send :include, AreaSelectCn::Helpers::FormBuilderExtension
::SimpleForm::FormBuilder.send :include, 
  AreaSelectCn::Hooks::SimpleFormBuilderExtension




