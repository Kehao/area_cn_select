//= require jquery
//= require jquery_ujs
//= require select2
//= require select2_locale_zh-CN
//= require area_select_cn/jquery.district-ul
//= require snap
//= require_self
$(function() {
  var snapper = new Snap({
    element: document.getElementById('content')
  });
  snapper.disable()
  //snapper.open('left');
})

