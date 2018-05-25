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
        "--output-public-path http://localhost:8080/#{app.config[:js_dir]}",
        "--config #{app.root_path}/config/webpack/development.js"
      )
    end
  end
end
