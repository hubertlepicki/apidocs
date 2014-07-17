require_relative './features_helper'

feature 'Homepage', js: true do
  scenario 'should show API.rdoc rendered as HTML' do
    visit '/apidocs'

    page.should have_css('h1', text: 'This is a sample dummy readme')
  end

  scenario 'should show project title' do
    visit '/apidocs'

    page.should have_content("Dummy APP")
  end
end
