#encoding: utf-8
require 'spec_helper'

TEST_CODE = "340000"

feature 'visit the testpage' do
  scenario 'page should init district-ul select' do
    visit "/" 
    assert_select_exist
    assert_district_ul(TEST_CODE)
  end

  scenario 'page should init other district-ul select' do
    visit "/"
    assert_district_ul(AreaSelectCn::District.id(TEST_CODE))
  end

  scenario 'select area',:driver => :webkit do
    visit "/" 
    { :province => ["安徽省","340000"],
      :city     => ["合肥市","340100"],
      :district => ["瑶海区","340102"] 
    }.each do |scope,area|
      page.execute_script(%Q{jQuery("li[data-value='#{area[1]}']").click();})
      assert_district_ul(AreaSelectCn::District.id(area[1]))
    end

    #page.execute_script(%Q{jQuery("li[data-value='310000']").click();})
    #assert_district_ul(AreaSelectCn::District.id('310000'))
  end

  def province_blank
    ["省 份", ""]
  end

  def city_blank
    ["城 市", ""]
  end

  def district_blank
    ["区 县",""]
  end

  def assert_select_exist
    page.should have_css('dl.area-select-cn')
    page.source.should have_selector('dd.select-input',:count => 3)
    page.source.should have_selector('ul.select-opts',:count => 3)
    #page.assert_selector('dd.select-input',:count => 3)
    #page.assert_selector('ul.select-opts', :count => 3)
  end

  def assert_district_ul(area_id)
    assert_page_select_content(area_id)
    assert_page_select_opts(area_id)
  end

  def assert_page_select_opts(area_id)
    [:province,:city,:district].each do |scope|
      selected = area_id.public_send("selected_#{scope.to_s.pluralize}")
      selected.unshift(public_send("#{scope}_blank")).sort!
      page_select_opts(scope).should eql(selected)
    end
  end

  def assert_page_select_content(area_id)
    [:province,:city,:district].each do |scope|
      if area_id.public_send(scope)
        find(".#{scope} .select-content").text.should eq(area_id.public_send("#{scope}_name"))
        find(".#{scope} .select-content")['data-value'].should eq(area_id.public_send("#{scope}_id"))
      else
        find(".#{scope} .select-content").text.should eq(public_send("#{scope}_blank")[0])
        find(".#{scope} .select-content")['data-value'].should be_blank
      end
    end
  end

  def page_select_opts(scope)
    Capybara.string(page.body).all(".#{scope} .select-opts li").map do |li|
      [li.text,li['data-value']]
    end.sort
  end
end
