# Amco::Cas

This a drop-in engine to integrate amcoid(https://github.com/amco/amcoid) to amco apps

## Usage

This gem exposes a route to the main app which can be used with:

```ruby
= link_to amco_cas.logout_path, method: :delete
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubycas-client-rails', git: 'https://github.com/amco/rubycas-client-rails', branch: '0.1'
gem 'amco-cas'
```
note: The 'rubycas-client-rails' gem has to be added to the host application since it's not published to rubygems it's not possible to use it inside the `amco-cas` engine gemspec

And then execute:
```bash
$ bundle install
```

Mount the engine in your application routes.rb file with:

```ruby
mount Amco::Cas::Engine, at: 'amco_cas'
```

You will need to provide default values for the underlying RubyCas gem, this can be done in you application.rb file with:

```ruby
config.before_initialize do
  config.rubycas.cas_base_url = ::Settings.amco_id.cas_base_url
  config.rubycas.enable_single_sign_out = ::Settings.amco_id.enable_single_sign_out
  config.rubycas.ticket_store = Amco::Cas::RedisTicketStore
  config.rubycas.username_session_key = ::Settings.amco_id.username_session_key.to_sym
  Amco::Cas.config(config.rubycas)
end
```
### Current User

you should add the following snippet to expose the `current_user` method from the engine

```ruby
helper_method :current_user
```

to override or decorate the current user object you can do the following in you `application_controller` :

```ruby
def current_user
  OpenStruct.new(user: super, context: { role: 'av_admin' } )
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
