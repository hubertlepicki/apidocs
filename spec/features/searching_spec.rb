require_relative './features_helper'

feature 'Searching', js: true do
  scenario 'should show relevant paths' do
    visit '/apidocs'

    fill_in "Filter", with: 'bar'
    page.should have_link('/api/bar')
    page.should_not have_link('/api/session')
  end
end
