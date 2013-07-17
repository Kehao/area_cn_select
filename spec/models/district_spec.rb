#encoding: utf-8
require 'spec_helper'

describe AreaSelectCn::District do
  it "get(nil) should be nil" do 
    subject.id(nil).should be_nil 
  end 

  it "get('33100a') should be nil" do  
    subject.id("33100a").get.should be_nil 
  end
  
  it "should get province,city and district form id" do
    id = subject.id(331002)
    
  end
end
