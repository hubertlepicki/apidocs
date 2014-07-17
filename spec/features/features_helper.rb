require_relative '../spec_helper'
require 'capybara/rspec'

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
Capybara.default_wait_time = 10

