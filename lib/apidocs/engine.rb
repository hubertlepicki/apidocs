module Apidocs
  class Engine < ::Rails::Engine
    isolate_namespace Apidocs
    require 'bootstrap-sass'
  end
end
