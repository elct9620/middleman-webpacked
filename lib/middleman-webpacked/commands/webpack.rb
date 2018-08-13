require 'middleman-core/cli'

module Middleman
  module Cli
    class Webpack < ::Thor::Group
      include Thor::Actions

      BABEL_TEMPLATE = File.expand_path('../../template/babelrc.tt', __FILE__)
      SHARED_WEBPACK_TEMPLATE = File.expand_path('../../template/shared.webpack.tt', __FILE__)
      DEVELOPMENT_WEBPACK_TEMPLATE = File.expand_path('../../template/dev.webpack.tt', __FILE__)
      PRODUCTION_WEBPACK_TEMPLATE = File.expand_path('../../template/prod.webpack.tt', __FILE__)

      check_unknown_options!

      class_option 'react',
        type: :boolean,
        default: false,
        desc: 'Add react support'

      class_option 'vue',
        type: :boolean,
        default: false,
        desc: 'Add vue support'

      def self.source_root
        File.expand_path('../../template', __FILE__)
      end

      def initialize(*args)
        super

        @app = ::Middleman::Application.new do
          config[ :mode ]              = :config
          config[ :disable_sitemap ]   = true
          config[ :watcher_disable ]   = true
          config[ :exit_before_ready ] = true
        end

        @packages = default_packages
      end

      def webpack
        @presets = ['env']
        @plugins = []
        @loaders = []

        enable_react if options[:react]
        enable_vue if options[:vue]

        generate_config
        run "yarn add #{@packages.join(' ')} --dev"
      end

      def generate_config
        template BABEL_TEMPLATE, File.join(@app.root_path, '.babelrc')
        template SHARED_WEBPACK_TEMPLATE, File.join(@app.root_path, 'config', 'webpack', 'shared.js')
        template DEVELOPMENT_WEBPACK_TEMPLATE, File.join(@app.root_path, 'config', 'webpack', 'development.js')
        template PRODUCTION_WEBPACK_TEMPLATE, File.join(@app.root_path, 'config', 'webpack', 'production.js')
      end

      def enable_react
        @packages.push(
          'babel-preset-react',
          'react',
          'react-dom',
          'react-hot-loader'
        )
        @presets = ['env', 'react']
        @loaders.push({
          test: /\.(js|jsx)$/,
          use: 'babel-loader'
        })
      end

      def enable_vue
        @packages.push(
          'vue',
          'babel-preset-es2015',
          'vue-loader',
          'vue-template-compiler'
        )
        @presets = ['env', 'es2015']
        @loaders.push({
          test: /\.vue$/,
          use: 'vue-loader',
        },{
          test: /\.js$/,
          use: 'babel-loader'
        })
      end

      # Add to CLI
      Base.register( self, 'webpack', 'webpack [options]', 'Install webpack to middleman')

      protected

      def default_packages
        [
          'webpack',
          'webpack-cli',
          'webpack-merge',
          'webpack-dev-server',
          'babel-loader',
          'babel-core',
          'babel-preset-env',
          'compression-webpack-plugin'
        ]
      end
    end
  end
end
