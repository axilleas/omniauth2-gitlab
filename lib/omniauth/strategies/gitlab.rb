require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class GitLab < OmniAuth::Strategies::OAuth2
       option :name, 'gitlab'

       option :client_options, {
         site: 'https://gitlab.com',
         authorize_url: '/oauth/authorize/',
         token_url: '/oauth/token/'
       }

      uid { raw_info["id"] }

      info do
        {
          email: raw_info["email"],
          username: raw_info["username"],
          name: raw_info["name"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v3/user').parsed
      end

    end # GitLab
  end # Strategies
end # OmniAuth
