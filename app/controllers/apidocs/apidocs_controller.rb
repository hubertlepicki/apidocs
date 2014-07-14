require_dependency "apidocs/application_controller"

module Apidocs
  class ApidocsController < ApplicationController
    def index
      @routes = Apidocs::ApiDocs.new.generate_html
    end
  end
end
