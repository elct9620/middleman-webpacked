# Require core library
require 'middleman-core'

# Extension namespace
module Middleman
  class WebpackExtension < ::Middleman::Extension
    option :source, '.tmp/dist', 'The webpack dist path'

    WEBPACK_DEV_SERVER_BIN = 'node_modules/.bin/webpack-dev-server'
    WEBPACK_BIN = 'node_modules/.bin/webpack'

    def initialize(app, options_hash={}, &block)
      super

      fail 'Webpack Dev Server not found' unless File.exists?(WEBPACK_DEV_SERVER_BIN)
      fail 'Webpack not found' unless File.exist?(WEBPACK_BIN)
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
      return build_command if app.build?
      "#{WEBPACK_DEV_SERVER_BIN} --mode development " \
      '--module-bind js=babel-loader ' \
      '--hot --progress --color --inline --content-base source ' \
      "--output-public-path /#{app.config[:js_dir]}"
    end

    def build_command
      "#{WEBPACK_BIN} --mode production " \
      '--module-bind js=babel-loader ' \
      "--bail -p --output #{options.source}/#{app.config[:js_dir]}/main.js"
    end

    helpers do
      def javascript_pack_tag(name)
        return javascript_include_tag "#{app.config[:js_dir]}/#{name}" if app.build?
        javascript_include_tag "http://localhost:8080/#{app.config[:js_dir]}/#{name}.js"
      end
    end
  end
end
