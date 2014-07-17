ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment', __FILE__)

require 'rspec/rails'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.include RSpec::Matchers
  config.include Capybara::DSL, type: :feature

  config.before do |example|
  end

  config.after(:each) do
  end
end
