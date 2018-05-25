module MiddlemanWebpacked
  class Server < CommandRunner
    bin 'node_modules/.bin/webpack-dev-server'
    mode :development

    def setup
      @arguments.push(
        '--hot',
        '--progress',
        '--color',
        '--inline',
        '--content-base source',
        "--output-public-path /#{app.config[:js_dir]}"
      )
    end
  end
end
