require_dependency "apidocs/application_controller"

module Apidocs
  class ApidocsController < ApplicationController
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
  end
end
