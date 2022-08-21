# OrderId

If you're tired of creating a _kinda_ unique ids based on a timestamp, look no further.
OrderId will create a hash-looking id strings that are nice and decodable back to a timestamp.
`3I7BX-6WERP-CD4` is much better than `1661113911.978755`.

Basically, it takes a current timestamp and translates it to a string of upper-cased characters split in groups 
of XX chars separated by a custom separator-char. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'OrderId'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install OrderId

## Usage

```ruby
OrderId.generate # G3RRY-ZMIHR-CCZ3P-FGXM
OrderId.get_time('G3RRY-ZMIHR-CCZ3P-FGXM') # 2022-08-21 20:33:18 +0000
```
### Parameters
OrderId takes four optional parameters:
- `length`: number of decimal places in a timestamps. Makes no sense if it's over 20, common sense is 10 or 12.
- `base`: base number system. Defaults to 36, but any arbitrary base is a good place to obfuscate your ids. E.g . `OrderId.generate(base: 12) # 12616-51312-6751B-A87B1-72235-444`
- `separator`: a separator char. Defaults to `-` but can be `'/'` or any non-digit and non-word character
- `group_length`: a number of chars in groups separated by a `separator`. Defaults to 4. `OrderId.generate(base: 12, length: 4, group_length: 8) # "1A434285-32526"`

### Restoring a timestamp from an Id
If you know the parameters which the Id has been generated with you can restore a timestamp the Id was based on.

```ruby
OrderId.get_time('1A434285-32526', base: 12, length: 4) # 2022-08-21 20:49:34 +0000
``` 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/austerlitz/OrderId. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OrderId project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/austerlitz/OrderId/blob/master/CODE_OF_CONDUCT.md).
