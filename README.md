# Omniauth2::Gitlab

This is the official OmniAuth strategy for authenticating to GitLab. To use it,
you'll need to sign up for an OAuth2 Application ID and Secret on your GitLab
Applications Page (`admin/applications/`).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth2-gitlab'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth2-gitlab

## Usage

In your `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :gitlab, ENV['GITLAB_APP_ID'], ENV['GITLAB_SECRET']
end
```

By default it uses `https://gitlab.com` for authentication. To change to your
site:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :gitlab, ENV['GITLAB_APP_ID'], ENV['GITLAB_SECRET'],
    {
      :client_options => {
        :site => 'https://YOURDOMAIN.com',
      }
    }
end
```

Then, register a new application in your GitLab server and start your Rails
application by providing the environment variables `GITLAB_APP_ID` and
`GITLAB_SECRET`.

## LICENSE

MIT, see [LICENSE](./LICENSE).
