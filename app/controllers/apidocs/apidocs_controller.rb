require_dependency "apidocs/application_controller"

module Apidocs
  class ApidocsController < ApplicationController
    before_action :authenticate
    before_action :clean_cache, if: -> { Rails.env.development? }

    def index
      @routes = routes_rdoc
      if params[:search]
        @searchinput = params[:search]
      end

      if params[:path]
        @route = routes_rdoc[params[:path]]
      else
        @intro = intro_rdoc
      end
    end

    private

    def routes_rdoc
      Rails.cache.fetch("routes_rdoc_html") do
        routes = Apidocs::ApiDocs.new.generate_html
        routes.group_by { |r| r[:path] }
      end
    end

    def intro_rdoc
      RDoc::Markup::ToHtml.new(RDoc::Options.new).convert(Rails.root.join('API.rdoc').read)
    rescue
      ""
    end

    def authenticate
      if Apidocs.configuration.http_username && Apidocs.configuration.http_password
        authenticate_or_request_with_http_basic do |u, p|
          u == Apidocs.configuration.http_username && Digest::MD5.hexdigest(p) == Apidocs.configuration.http_password
        end
      end
    end

    def clean_cache
      Rails.cache.delete("routes_rdoc_html")
    end
  end
end
