require_relative './features_helper'

feature 'Homepage', js: true, driver: :selenium do
  scenario 'should show API.rdoc rendered as HTML' do
    visit '/apidocs'

    page.should have_css('h1', text: 'This is a sample dummy readme')
  end
end
