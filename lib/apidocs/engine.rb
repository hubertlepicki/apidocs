module Apidocs
  class Engine < ::Rails::Engine
    isolate_namespace Apidocs
    require 'bootstrap-sass'
    require "jquery-rails"
  end
end
