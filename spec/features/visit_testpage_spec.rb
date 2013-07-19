require 'spec_helper'

feature 'visit the testpage' do

  scenario 'page should have district-ul select' do
    visit root_path
    page.should have_css("dl.area-select-cn")
    page.assert_selector('dd.select-input', :count => 3)
    page.assert_selector('ul.select-opts', :count => 3)

  end

end
