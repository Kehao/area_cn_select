# encoding: utf-8
class AreaSelectCnCompaniesController < ApplicationController
  def index
  end

  def new
    @company = AreaSelectCn::Company.new
    @company.region_code = 331002
  end

  def create
    @company= AreaSelectCn::Company.new(params[:area_select_cn_company])
    respond_to do |format|
      if @company.save
        format.html { redirect_to new_area_select_cn_company_path,notice: "添加成功" }
      else
        format.html { render action: "edit"}
      end
    end
  end

  def edit

  end
end
