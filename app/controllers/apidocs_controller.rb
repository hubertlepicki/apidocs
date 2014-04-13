require 'digest/sha1'

class ApidocsController < ActionController::Base
  def index
    @routes = ApiDocs.new.generate_html
  end
end
