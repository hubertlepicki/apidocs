require "apidocs/engine"

module Apidocs
  require 'rdoc'
  require 'action_dispatch/routing/inspector'
  require 'fileutils'
  # This is class comment
  class ApiDocs < RDoc::RDoc
    # generate_html entry point for on fly document generation
    def generate_html
      FileUtils.rm_rf(Rails.root.join('tmp/apidocs'))
      options = [Rails.root.join("app/controllers").to_s, "--op=#{Rails.root.join('tmp/apidocs')}"]

      self.store = RDoc::Store.new

      @options = load_options
      @options.parse options
      @exclude = @options.exclude

      @last_modified = setup_output_dir @options.op_dir, @options.force_update

      @store.encoding = @options.encoding if @options.respond_to? :encoding
      @store.dry_run = @options.dry_run
      @store.main = @options.main_page
      @store.title = @options.title
      @store.path = @options.op_dir

      @start_time = Time.now
      @store.load_cache
      @options.default_title = "RDoc Documentation"

      parse_files @options.files
      @store.complete @options.visibility
      Apidocs.configuration.regex_filter
      all_routes = Rails.application.routes.routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
      routes = inspector.send(:collect_routes, inspector.send(:filter_routes, nil))\
         .select { |r| r[:reqs] =~ /#/ and (r[:path] =~ Apidocs.configuration.regex_filter) if Apidocs.configuration.regex_filter}

      formatter = RDoc::Markup::ToHtml.new(RDoc::Options.new)

      routes = routes.map do |r|
        {verb: r[:verb],
         path: r[:path].sub('(.:format)', ''),
         class_name: gen_class_name(r),
         action_name: gen_action_name(r)
        }
      end

      routes.each do |r|
        doc = document_route(r)
        r[:html_comment] = doc ? doc.accept(formatter) : ""
      end

      routes.select { |r| r[:class_name] != "ApidocsController" }
    end

    private

    def document_route(r)
      klas = @store.instance_variable_get("@classes_hash")[r[:class_name]]
      return nil if klas.nil?
      klas.methods_hash["##{r[:action_name]}"].try(:comment).try(:parse)
    end

    def gen_class_name(r)
      "#{r[:reqs].split("#").first}_controller".classify
    end

    def gen_action_name(r)
      "#{r[:reqs].split("#").last}"
    end
  end

  class Configuration
    attr_accessor :regex_filter, :http_username, :http_password, :app_name
    def initialize
      @regex_filter = /.*/
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
