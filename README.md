Middleman Webpacked
===

## Usage

Add this line to your `Gemfile`

```ruby
gem 'middleman-webpacked', '~> 0.0.3'
```

Setup your Webpack

```ruby
middleman webpack
```

> To enable React.js, add `--react` options when setup Webpack

Add `javascript_pack_tag` to your layout

```erb
<%= javascript_pack_tag 'bundle' %>
```

Activate the extension in `config.rb`

```ruby
activate :webpack
```

Put the javascript into `src` directory

> This version only support Webpack 4 default config

## Options

### Entry

If you want to output more than one file (`bundle.js`) you can specify the entry options.

```ruby
activate :webpack,
         entry: {
           app: 'index.js',
           ext: 'ext.js'
         }
```

## Roadmap

* [x] Running Webpack without config
* [ ] Automatic setup `webpack.config.js`
* [x] Babel Support
* [x] React.js Support
* [ ] Vue.js Support
* [ ] Sass Support
