#encoding: utf-8
require 'spec_helper'
describe AreaSelectCn::Id do

  context "legal region code" do
    subject{AreaSelectCn::Id.new("331002")}
    it{expect(subject.id).to eq("331002")}
    it{expect(subject.province_id).to eq("330000")}
    it{expect(subject.city_id).to eq("331000")}
    it{expect(subject.district_id).to eq("331002")}
    
    it "should return province_id" do
      expect(AreaSelectCn::Id.new("00000a").province_id).to be_nil 
      expect(AreaSelectCn::Id.new("000000").province_id).to be_nil 
      expect(AreaSelectCn::Id.new("330000").province_id).to eq("330000")
      expect(AreaSelectCn::Id.new("331000").province_id).to eq("330000")
      expect(AreaSelectCn::Id.new("331002").province_id).to eq("330000")
    end

    it "should return city_id" do
      expect(AreaSelectCn::Id.new("00000a").city_id).to be_nil 
      expect(AreaSelectCn::Id.new("000000").city_id).to be_nil 
      expect(AreaSelectCn::Id.new("330000").city_id).to be_nil
      expect(AreaSelectCn::Id.new("331000").city_id).to eq("331000")
      expect(AreaSelectCn::Id.new("331002").city_id).to eq("331000")
    end

    it "should return district_id" do
      expect(AreaSelectCn::Id.new("00000a").district_id).to be_nil 
      expect(AreaSelectCn::Id.new("000000").district_id).to be_nil 
      expect(AreaSelectCn::Id.new("330000").district_id).to be_nil
      expect(AreaSelectCn::Id.new("331000").district_id).to be_nil 
      expect(AreaSelectCn::Id.new("331002").district_id).to eq("331002")
    end

    it "should return area type" do
      expect(AreaSelectCn::Id.new("330000")).to be_province
      expect(AreaSelectCn::Id.new("330000")).not_to be_city
      expect(AreaSelectCn::Id.new("330000")).not_to be_district

      expect(AreaSelectCn::Id.new("331000")).to be_city
      expect(AreaSelectCn::Id.new("331000")).not_to be_province
      expect(AreaSelectCn::Id.new("331000")).not_to be_district

      expect(AreaSelectCn::Id.new("331002")).to be_district
      expect(AreaSelectCn::Id.new("331002")).not_to be_city
      expect(AreaSelectCn::Id.new("331002")).not_to be_province
    end

    it "should return area" do 
      expect(AreaSelectCn::Id.new("331002").province[:text]).to eq("浙江省")
      expect(AreaSelectCn::Id.new("331002").city[:text]).to eq("台州市")
      expect(AreaSelectCn::Id.new("331002").district[:text]).to eq("椒江区")

      expect(AreaSelectCn::Id.new("330000").city).to be_nil
      expect(AreaSelectCn::Id.new("330000").district).to be_nil
    end

    it "should get detail area" do
      expect(AreaSelectCn::Id.new("330000").get[:children]).not_to be_blank
      expect(AreaSelectCn::Id.new("331000").get[:children]).not_to be_blank
      expect(AreaSelectCn::Id.new("331002").get[:children]).to be_nil
    end

    it "should get area name" do
      expect(AreaSelectCn::Id.new("330000").area_name).to eq("浙江省")
      expect(AreaSelectCn::Id.new("331000").area_name).to eq("浙江省-台州市")
      expect(AreaSelectCn::Id.new("331002").area_name).to eq("浙江省-台州市-椒江区")
    end

  end

end
