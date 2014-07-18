require_relative './features_helper'

feature 'Browsing documentation', js: true do
  scenario 'should navigate to individual pages' do
    visit '/apidocs'

    click_link '/api/session'
    page.should have_content("POST /api/session")
    page.should have_content("Logs user in. When failed, status of 422 is returned. When success, 200 OK and a cookie is set.")
  end
end
