Middleman Webpack
===

## Usage

Add this line to your `Gemfile`

```ruby
gem 'middleman-webpack', '~> 0.0.1'
```

Setup your Webpack

```ruby
yarn add webpack webpack-dev-server webpack-cli --dev
```

Add `javascript_pack_tag` to your layout

```erb
<%= javascript_pack_tag 'main' %>
```

Activate the extension in `config.rb`

```ruby
activate :webpack
```

Put the javascript into `src` directory

> This version only support Webpack 4 default config

## Roadmap

* [x] Running Webpack without config
* [ ] Automatic setup `webpack.config.js`
* [ ] Babel Support
* [ ] React.js Support
* [ ] Vue.js Support
