require "middleman-core"

Middleman::Extensions.register :webpack do
  require "middleman-webpacked/commands/webpack"
  require "middleman-webpacked/extension"

  Middleman::WebpackedExtension
end
