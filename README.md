## 地区选择插件(测试中) [![Gem Version](https://badge.fury.io/rb/area_cn.png)](http://badge.fury.io/rb/area_cn)
  整理各种地区选择器

## Example ScreenShot
### defaule theme
![Default Theme](https://raw.github.com/Kehao/area_select_cn/master/vendor/assets/images/area_select_cn/default-theme.png)

### bootstrap theme
![Bootstrap Theme](https://raw.github.com/Kehao/area_select_cn/master/vendor/assets/images/area_select_cn/bootstrap-theme.png)

##Features
  1. 支持bootstrap  
  2. 支持simple_form

##TODO
  1. view helper area_select_cn_tag(done)
  2. 兼容rails 4.0
  3. auto complete 选择器
  4. editable
  5. 兼容ie6 

##Installation

Add it to your Gemfile:
```ruby
  gem 'area_select_cn',:git=>"git@github.com:Kehao/area_select_cn.git"
```

And then execute:
```console
  bundle install
```

## FormHelper
###form_tag
```erb
  <%= form_tag "" do %>
    <%= area_select_cn(:company,:region_code,"331000",:theme=>:bootstrap,:prompt_class=>"btn btn-danger") %>
  <% end %>
```

###form_for
```erb
  <%= form_for Company.new,:builder => AreaSelectCn::Helpers::FormBuilder do |f| %>
    <%= f.area_select_cn :region_code%>
  <%end%>
```

###simple_form_for
  <%= simple_form_for Company.new,:html => { :class => 'form-horizontal' } do |f| %>
    <%= f.input :region_code,:as => :area_select_cn, :input_html=>{:prompt_class=>"btn btn-warning"}%>
  <% end %>

##Theme
  1. default
  2. bootstrap

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

