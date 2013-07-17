#encoding: utf-8
require 'spec_helper'
describe AreaSelectCn::Parser do
  context "area list" do
    before {@code = "331002"}
    subject { AreaSelectCn::Parser.list }
    it "['330000'] should return cities" do
      expect(subject['330000'][:text]).to eq("浙江省")
      expect(subject['330000'][:children]).to be_present
    end

    it "['330000'][:children]['331000'] should return districts" do
      area = subject['330000'][:children]['331000']
      expect(area[:text]).to eq("台州市")
      expect(area[:children]).to be_present
    end

    it "['330000'][:children]['331000'][:children]['331002'] should return district" do
      area = subject['330000'][:children]['331000'][:children]['331002']
      expect(area[:text]).to eq("椒江区")
      expect(area[:children]).to be_blank
    end

  end
end
