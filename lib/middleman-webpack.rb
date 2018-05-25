require "middleman-core"

Middleman::Extensions.register :webpack do
  require "middleman-webpack/commands/webpack"
  require "middleman-webpack/extension"

  Middleman::WebpackExtension
end
