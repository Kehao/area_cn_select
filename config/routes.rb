Rails.application.routes.draw do
  # 返回树状结构的省，市，区县数据
  get '/area_select_cn/district',
    :to => AreaSelectCn::DistrictController.action(:index)
end
