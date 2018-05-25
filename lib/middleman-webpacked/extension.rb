# Require core library
require 'middleman-core'

require 'middleman-webpacked/command_runner'
require 'middleman-webpacked/server'
require 'middleman-webpacked/build'

# Extension namespace
module Middleman
  class WebpackedExtension < ::Middleman::Extension
    include MiddlemanWebpacked

    option :source, '.webpack-cache', 'The webpack cache path'
    option :entry, {bundle: 'index.js'}, 'The entry points(s) of the compilation'

    def initialize(app, options_hash={}, &block)
      super

      fail 'Webpack Dev Server not found' unless Server.satisfy?
      fail 'Webpack not found' unless Build.satisfy?
    end

    def after_configuration
      active_webpack
    end

    def active_webpack
      app.activate :external_pipeline,
        name: :webpack,
        command: command,
        source: options.source,
        latency: 1
    end

    def command
      if app.build?
        Build
      else
        Server
      end.new(app, options).command
    end

    def after_build
      FileUtils.rm_rf(options.source)
    end

    helpers do
      def javascript_pack_tag(name)
        return javascript_include_tag "#{app.config[:js_dir]}/#{name}" if app.build?
        javascript_include_tag "http://localhost:8080/#{app.config[:js_dir]}/#{name}.js"
      end
    end
  end
end
