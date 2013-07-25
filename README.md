[![Gem Version](https://badge.fury.io/rb/area_cn.png)](http://badge.fury.io/rb/area_cn)
## 地区选择插件(测试中) 
  整理多种地区选择器:

  1. select-ul 模拟下拉菜单(done;testing)
  2. select 下拉菜单
  3. auto complete 方式
  4. 弹出层
  5. 地图(maybe)
  6. ???

## Example
### Defaule theme
![Default Theme](https://raw.github.com/Kehao/area_select_cn/master/vendor/assets/images/area_select_cn/default-theme.png)

### Bootstrap theme
![Bootstrap Theme](https://raw.github.com/Kehao/area_select_cn/master/vendor/assets/images/area_select_cn/bootstrap-theme.png)

##Features
  1. 支持bootstrap  
  2. 支持simple_form

##TODO
  1. from_tag_helper area_select_ul(done)
  2. 错误处理
  3. 支持x-editable **http://vitalets.github.io/x-editable/demo.html**
  4. auto complete 选择器
  5. 兼容rails 4.0
  6. 兼容ie6 

##Installation

Add it to your Gemfile:
```ruby
gem 'area_select_cn',:git=>"git@github.com:Kehao/area_select_cn.git"
```

And then execute:
```console
bundle install
```

Add it to your application.js:

```console
//= require area_select_cn/jquery.district-ul
```

if you want to use the default theme, add it to your application.css:
```console
*= require area_select_cn/district-ul
```

## FormHelper
###form_tag
```erb
<%= form_tag "" do %>
  <%= area_select_ul(:company,:region_code,"331000") %>
<% end %>
```

###form_for
```erb
<%= form_for Company.new,:builder => AreaSelectCn::Helpers::FormBuilder do |f| %>
  <%= f.area_select :region_code%>
<%end%>
```

###simple_form_for
```erb
<%= simple_form_for Company.new,:html => { :class => 'form-horizontal' } do |f| %>
  <%= f.input :region_code,:as => :area_select}%>
<% end %>
```

##Theme
  1. default
  2. bootstrap

if you want to use the default theme, add it to your application.css:
```console
*= require area_select_cn/district-ul
```
if you want to use bootstrap theme, you should import bootstrap css.

```erb
<!-- form_tag -->
<%= area_select_ul(:company,:region_code,"331000",:theme=>:bootstrap) %>

<!-- form_for -->
<%= f.area_select :region_code,:theme=>:bootstrap,:prompt_class=>"btn btn-success"%>

<!-- simple_form_for,如果SimpleForm.wrapper等于:bootstrap，默认样式为:bootstrap -->
<%= f.input :region_code,:as => :area_select %>
```
## Resources
* Chosen(http://harvesthq.github.io/chosen/)
* X-editable(http://vitalets.github.io/x-editable/demo.html)

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

