# encoding: utf-8
module AreaSelectCn
  class DistrictController < ActionController::Base
    layout nil
    # 返回树状结构的整个省份，城市，区域列表，
    # 避免选择地区时的多次请求 
    def index
      code = params[:region_code] 
      results = 
        if code 
          AreaSelectCn::Id.new(code).children
        else
          AreaSelectCn::District.list
        end
      render :json => results
    end

    def search
      ids = []
      if params[:region_name]
        ids = AreaSelectCn::District.search(params[:region_name])
      end
      render :json => ids.map{|id|{:id=>id.code,:text=>id.area_name}}
    end
  end
end
