# Grist::Ruby

This gem provides a Ruby client for the Grist API. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grist-ruby'
```

And install the gem:

```bash
$ bundle install
```

## Usage

See `examples/main.rb`

## Development

Start a Grist dockerized instance locally and run the console

```bash
$ docker run -d --rm -p 8484:8484 --name grist -v ./volumes/data:/persist:rw -e GRIST_SESSION_SECRET=invent-a-secret-here -it gristlabs/grist

$ GRIST_API_KEY=<GRIST_API_KEY> GRIST_API_URL=http://localhost:8484 bundle exec bin/console
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/grist-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/grist-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Grist::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/grist-ruby/blob/main/CODE_OF_CONDUCT.md).

## Resources
* https://support.getgrist.com/api/#tag/records/operation/addRecords