# encoding: utf-8
module AreaSelectCn
  module Helpers
    module ToAreaSelectCnTag
      def to_area_select_ul_tag(region_code,options,html_options)
        random = "area_select_ul_#{SecureRandom.hex}"
        body = ''
        body << to_input_field_tag("hidden",:class => "select-value",:value=>region_code)
        [:province,:city,:district].each do |scope|
          body << area_select_ul_scope_select(scope,options,html_options)
        end
        body = content_tag(:div,body.html_safe,:class=>"area_select_ul #{random} clearfix")
        body << area_select_ul_javascript_tag(random,options)
        body 
      end

      def area_select_ul_javascript_tag(random,opts)
        javascript = <<-JAVASCRIPT
          <script>
             jQuery.District(".#{random}",{
               selectContainer:        '.#{opts[:select][:class]}',
               selectOptsContainer:    '.#{opts[:select_options][:class]}',
               selectPromptContainer:  '.#{opts[:select_prompt][:class]}',
                 onChange: function($container,code){ 
                 $container.find(".select-value").val(code); }
            })
          </script>
        JAVASCRIPT
        javascript.html_safe
      end

      def area_select_ul_selected(cur,required,class_name="active")
        required = [required].flatten
        required.index(cur) && class_name 
      end 

      def area_select_ul_scope_select(scope,options,html_options)
        scope_blank_prompts = { 
          :province => "省 份", :city => "城 市", :district => "区 县"
        }
        selected_scope  = options["selected_#{scope}".intern]
        selected_scopes = options["selected_#{scope.to_s.pluralize}".intern]

        pmt = ''
        data_value = selected_scope && {:value=>selected_scope[1]} || {}
        data_text = selected_scope && selected_scope[0] || scope_blank_prompts[scope]
        pmt << content_tag(:span,data_text,:class=>"select-content",:data => data_value)
        pmt << content_tag(:span,"",options[:caret])

        opts = '' 
        blank_link = @template_object.link_to(scope_blank_prompts[scope],"javascript:void(0);")
        opts << content_tag(:li,blank_link,:class =>area_select_ul_selected(selected_scope,nil), :data=>{:value => ""}) 

        selected_scopes.each do |scope|
          scope_link =  @template_object.link_to scope[0],"javascript:void(0);"
          opts << content_tag(:li,scope_link,:class =>area_select_ul_selected(scope[1],selected_scope && selected_scope[1]),:data => {:value => scope[1]}) 
        end
        
        prompt_class = {
          :class=>[options[:select_prompt][:class],options[:prompt_class]].join(" ")
        }
        prompt = @template_object.link_to(pmt.html_safe,"javascript:void(0);",options[:select_prompt].merge(prompt_class)) 
        select_options = content_tag(:ul,opts.html_safe,options[:select_options].merge(:style=>"max-height:350px;overflow:scroll")) 

        select = prompt + select_options
        content_tag(:div,select,options[:select])
      end
    end

  end
end
