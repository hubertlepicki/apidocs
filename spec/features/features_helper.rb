require_relative '../spec_helper'
require 'capybara/rspec'

Capybara.javascript_driver = :selenium
Capybara.default_driver = :selenium
Capybara.default_wait_time = 5

