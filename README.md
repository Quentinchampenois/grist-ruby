[![Ruby](https://github.com/Quentinchampenois/grist-ruby/actions/workflows/main.yml/badge.svg)](https://github.com/Quentinchampenois/grist-ruby/actions/workflows/main.yml)
# Grist

Grist ruby library to interact with [Grist](https://www.getgrist.com/) API.

* [Get Grist](https://www.getgrist.com/)
* [Grist API Documentation](https://support.getgrist.com/api/)
* [Grist Core](https://github.com/gristlabs/grist-core)

## Installation

Add this line to your application's Gemfile:

```ruby
    gem "grist", git: "https://github.com/quentinchampenois/grist.git"
```

_First release will be published on RubyGems_

## Examples

List all organizations

```ruby
require "faraday"
require "grist"

client = Grist::Client.new(url: "http://localhost:8484", token: "API_TOKEN")
puts client.organizations
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quentinchampenois/grist.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Grist project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/grist/blob/main/CODE_OF_CONDUCT.md).
