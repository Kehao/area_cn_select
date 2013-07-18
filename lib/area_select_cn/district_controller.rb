# encoding: utf-8
module AreaSelectCn
  class DistrictController < ActionController::Base
    layout nil

    # 返回树状结构的整个省份，城市，区域列表，
    # 避免选择地区时的多次请求 
    def index
      render :json => AreaSelectCn::District.list
    end

    #def list
    #  @result = District.list(params[:id])
    #  render :json => @result
    #end
  end
end
