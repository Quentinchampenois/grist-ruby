# Grist::Ruby

This gem provides a Ruby client for the Grist API. 

⚠️ Library isn't ready to use, not actively maintained

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grist'
```

And install the gem:

```bash
$ bundle install
```

## Usage

See `examples/main.rb` for some examples, here is how to use them:

* First example will create 1 Workspace, with 2 Documents, with 3 tables into document 'demo'.
  how to use it
```bash
$  GRIST_API_KEY=<GRIST_API_KEY> GRIST_API_URL=http://localhost:8484/api bundle exec examples/main.r
```

* `GRIST_API_URL` base url must contain `/api`

* Second example will update records
```bash
GRIST_ORG_NAME=<ORGANIZATION_NAME> GRIST_API_KEY=<GRIST_API_KEY> GRIST_API_URL=http://localhost:8484/api bundle exec examples/update.rb
```

* `ORGANIZATION_NAME` is case-sensitive


## Development

1. Start a Grist instance locally
```bash
$ docker compose up -d
```

### Playground using IRB
Then start the ruby console
```
$ GRIST_API_KEY=<GRIST_API_KEY> GRIST_API_URL=http://localhost:8484/api bundle exec bin/console
```
* GRIST_API_KEY can be found directly into your account at : http://localhost:8484/o/docs/account

You can now interact with Grist, example : `$ Grist::Type::Organization.all`

## Push a new release to RubyGems

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/grist-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/grist-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Grist::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/grist-ruby/blob/main/CODE_OF_CONDUCT.md).
