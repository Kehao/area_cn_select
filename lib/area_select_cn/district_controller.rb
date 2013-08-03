# encoding: utf-8
module AreaSelectCn
  class DistrictController < ActionController::Base
    layout nil
    # 返回树状结构的整个省份，城市，区域列表，
    # 避免选择地区时的多次请求 
    def index
      code = params[:region_code] 
      results = 
        unless code 
          AreaSelectCn::District.list
        else
          {:id=>code,:text => AreaSelectCn::District.id(params[:region_code]).area_name}
        end
      render :json => results
    end

    def search
      ids = []
      if params[:region_name]
        ids = AreaSelectCn::District.search(params[:region_name])
      end
      render :json => ids.map{|id|{:id=>id.id,:text=>id.area_name}}
    end
  end
end
