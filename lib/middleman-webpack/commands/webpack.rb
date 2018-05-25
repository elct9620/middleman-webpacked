require 'middleman-core/cli'

module Middleman
  module Cli
    class Webpack < ::Thor::Group
      include Thor::Actions

      check_unknown_options!

      def webpack
        run 'yarn add webpack webpack-dev-server webpack-cli --dev'
      end

      # Add to CLI
      Base.register( self, 'webpack', 'webpack [options]', 'Install webpack to middleman')
    end
  end
end
