# encoding: utf-8
module AreaSelectCn
  class DistrictController < ApplicationController
    layout nil

    # 返回树状结构的整个省份，城市，区域列表，
    # 避免选择地区时的多次请求 
    def index
      render :json => AreaSelectCn::District.list
    end

    def list
      @result = District.list(params[:id])
      render :json => @result
    end

    protected

    # 由于有的区县在不同省份名字是相同的，所以补上省市的名字
    def districts_with_fullname(districts)
      fullname_districts = []
      districts.each do |d| 
        dupd = d.dup
        fullname_districts.push(dupd)
        code = dupd['id']
        if District.city?(code)
          province_code = District.code_parent(code)
          dupd['text'] = District.get(province_code) + dupd['text']
        elsif District.county?(code)
          city_code = District.code_parent(code)
          province_code = District.code_parent(city_code)
          dupd['text'] = District.get(province_code) + District.get(city_code) + dupd['text']
        end
      end 

      fullname_districts
    end

  end
end
