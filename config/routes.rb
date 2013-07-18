Rails.application.routes.draw do

  # 返回树状结构的省，市，区县数据
  get '/area_select_cn/district',
    :to => AreaSelectCn::DistrictController.action(:index)

  # 地区选择
  #get '/area_select_cn/district/:id',
  #  :to => AreaSelectCn::DistrictController.action(:list)
end
