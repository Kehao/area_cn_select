#encoding: utf-8
require 'spec_helper'

describe AreaSelectCn::District do
  specify("get(nil) should be nil"){ subject.get(nil).should be_nil }
  specify("get('33100a') should be nil") { subject.get("33100a").should be_nil }

end
