# Spotlight::Atom

Harvest resources in Atom feeds into a Spotlight exhibit

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spotlight-atom-resources'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spotlight-atom

## Usage

This gem adds a new  "Repository Item" form to your Spotlight application. This form allows curators to input a URL to an Atom feed, and the contents of the feed will be harvested as new items in the Spotlight exhibit. Currently, this gem supports harvesting basic metadata from either Blacklight or Omeka feeds.

## Contributing

1. Fork it ( https://github.com/cbeer/spotlight-atom/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
