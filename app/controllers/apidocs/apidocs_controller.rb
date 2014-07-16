require_dependency "apidocs/application_controller"

module Apidocs
  class ApidocsController < ApplicationController
    before_action :authenticate

    def index
      @routes = routes_rdoc
      if params[:path]
        @route = routes_rdoc[params[:path]]
      else
        begin
          h = RDoc::Markup::ToHtml.new(RDoc::Options.new)
          @intro = h.convert(Rails.root.join('API.rdoc').read)
        rescue
          @intro = "Please put API.rdoc into "+Rails.root.to_s
        end
      end
    end

    def flush
      Rails.cache.delete("routes_rdoc_html")
      redirect_to :back
    end

    private
    def routes_rdoc
      Rails.cache.fetch("routes_rdoc_html") do
        routes = Apidocs::ApiDocs.new.generate_html
        routes.group_by { |r| r[:path] }
      end
    end

    protected
    def authenticate
      if Apidocs.configuration.http_username && Apidocs.configuration.http_password
        authenticate_or_request_with_http_basic do |u, p|
          u == Apidocs.configuration.http_username && Digest::MD5.hexdigest(p) == Apidocs.configuration.http_password
        end
      end
    end
  end
end

