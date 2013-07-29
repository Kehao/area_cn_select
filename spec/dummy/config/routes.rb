Dummy::Application.routes.draw do
  root :to => 'area_select_cn_companies#new'
  resources :area_select_cn_companies
end
