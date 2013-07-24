# encoding: utf-8
module AreaSelectCn
  module Helpers
    module ToAreaSelectCnTag
      def to_area_select_cn_tag(options,html_options)
        random = "area_select_cn_#{SecureRandom.hex}"
        body = ''
        body << to_input_field_tag("hidden",:class => "select-value")

        [:province,:city,:district].each do |scope|
          body << area_select_cn_scope_select(scope,options,html_options)
        end
        body = content_tag(:div,body.html_safe,:class=>"area_select_cn #{random} clearfix")
        body << area_select_cn_javascript_tag(random,html_options)
        body 
      end

      def area_select_cn_javascript_tag(random,opts)
        javascript = <<-JAVASCRIPT
          <script>
             jQuery.District(".#{random}",{
               selectContainer:        '.#{opts[:select][:class]}',
               selectOptsContainer:    '.#{opts[:select_options][:class]}',
               selectPromptContainer:  '.#{opts[:select_prompt][:class]}',
                 onChange: function(code){ $(".#{random} .select-value").val(code); }
            })
          </script>
        JAVASCRIPT
        javascript.html_safe
      end

      def area_select_cn_selected(cur,required,class_name="active")
        required = [required].flatten
        required.index(cur) && class_name 
      end 

      def area_select_cn_scope_select(scope,options,html_options)
        scope_blank_prompts = { 
          :province => "省 份", :city => "城 市", :district => "区 县"
        }
        selected_scope  = options["selected_#{scope}".intern]
        selected_scopes = options["selected_#{scope.to_s.pluralize}".intern]

        pmt = ''
        data_value = selected_scope && {:value=>selected_scope[1]} || {}
        data_text = selected_scope && selected_scope[0] || scope_blank_prompts[scope]
        pmt << content_tag(:span,data_text,:class=>"select-content",:data => data_value)
        pmt << content_tag(:span,"",html_options[:caret])

        opts = '' 
        blank_link = @template_object.link_to(scope_blank_prompts[scope],"javascript:void(0);")
        opts << content_tag(:li,blank_link,:class =>area_select_cn_selected(selected_scope,nil), :data=>{:value => ""}) 

        selected_scopes.each do |scope|
          scope_link =  @template_object.link_to scope[0],"javascript:void(0);"
          opts << content_tag(:li,scope_link,:class =>area_select_cn_selected(scope[1],selected_scope && selected_scope[1]),:data => {:value => scope[1]}) 
        end
        
        prompt_class = {
          :class=>[html_options[:select_prompt][:class],html_options[:prompt_class]].join(" ")
        }
        prompt = @template_object.link_to(pmt.html_safe,"javascript:void(0);",html_options[:select_prompt].merge(prompt_class)) 
        select_options = content_tag(:ul,opts.html_safe,html_options[:select_options]) 

        select = prompt + select_options
        content_tag(:div,select,html_options[:select])
      end
    end

  end
end
