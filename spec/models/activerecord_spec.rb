#encoding: utf-8
require 'spec_helper'
silence_warnings do
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Base.logger = Logger.new(nil)
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
end

ActiveRecord::Base.connection.instance_eval do
  create_table :companies do |t|
    t.string :name
    t.timestamps
  end

  create_table :area_select_cn_companies do |t|
    t.string :name
    t.timestamps
  end
end

class Company < ActiveRecord::Base
  attr_accessor :region_code
  attr_accessor :loc_code
  attr_accessible :region_code

  acts_as_area_field :region_code
  validates :region_code, presence: true
end

describe AreaSelectCn::ActsAsAreaSelectable do
  subject { Company.new }
  it "should return nil when attribute region_code is nil" do
    expect(subject.region_code).to be_nil
  end

  it "should return \"\" when attribute region_code eql \"\"" do
    subject.region_code = ""
    expect(subject.region_code).to eq("")
  end

  it "should return AreaSelectCn::Id instance" do
    subject.region_code = 331002
    expect(subject.region_code).to be_instance_of(AreaSelectCn::Id)
  end

  it "should cached" do
    subject.region_code = 331002
    expect(subject.region_code.object_id).to eq(subject.region_code.object_id)
  end

  it "331002 and \"\"331002\"\" shoud have diff cache " do
    subject.region_code = 331002
    cache1 = subject.region_code
    subject.region_code = "331002"
    cache2 = subject.region_code
    expect(cache1.object_id).not_to eq(cache2.object_id)
  end

  it "should return real value without acts_as_area_field" do
    subject.loc_code = 331002
    expect(subject.loc_code).to eq(331002)
    expect(subject.loc_code).not_to be_instance_of(AreaSelectCn::Id)
  end

  it "should be unvalid when region_code is blank" do
    subject.region_code = nil
    expect(subject).not_to be_valid
    expect(subject.save).to be_false
  end

end

