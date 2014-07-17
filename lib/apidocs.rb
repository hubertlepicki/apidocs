require "apidocs/engine"

module Apidocs
  require 'rdoc'
  require 'action_dispatch/routing/inspector'
  require 'fileutils'

  class ApiDocs < RDoc::RDoc
    # Generate rdoc documentation and combine with routes
    def documented_routes
      generate_rdoc
      apply_doc_to_routes
    end

    private

    def apply_doc_to_routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(Rails.application.routes.routes)
      routes = inspector.send(:collect_routes, inspector.send(:filter_routes, nil)).select { |r| filter_routes(r) }

      formatter = RDoc::Markup::ToHtml.new(RDoc::Options.new)

      routes.map do |r|
        doc = document_route(r)
        {verb: r[:verb],
         path: r[:path].sub('(.:format)', ''),
         class_name: gen_class_name(r),
         action_name: gen_action_name(r),
         html_comment: doc ? doc.accept(formatter) : ""
        }
      end
    end

    def generate_rdoc
      FileUtils.rm_rf(Rails.root.join('tmp/apidocs'))
      options = ["app/controllers", "--op=#{Rails.root.join('tmp/apidocs')}"]

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
    end

    def filter_routes(r)
      filter = Apidocs.configuration.regex_filter
      r[:reqs].include? '#' and (filter.present? ? r[:path] =~ filter : true) and !r[:reqs].include? 'ApidocsController'
    end

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
    attr_accessor :regex_filter, :http_username, :http_password
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration_clear
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
