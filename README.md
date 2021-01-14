# Auxilium

Auxilium contains an assortment of utility classes that are too small to warrant their own gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auxilium'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install auxilium

## Usage

Use the source :)

## Semver rake task

Auxilium contains a rake task that you can reuse in your projects to enable you to create releases using semantic versioning. To use this rake task in your own gems you need to do the following:

- Add auxilium to your gemspec (as atleast a development dependency) and to your Gemfile (specifying the right git source)
- Add the following snippet at the bottom of your Rakefile:

```ruby
# Adds the Auxilium semver task
spec = Gem::Specification.find_by_name 'auxilium'
load "#{spec.gem_dir}/lib/tasks/semver.rake"
```

After a bundle install you can see a new rake task named after your gem with the name gemname:semver

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/auxilium.

