require "tencent_weibo/version"
require "tencent_weibo/config"
require "tencent_weibo/client"
require "tencent_weibo/access_token"
require "tencent_weibo/api/v2/base"
require "tencent_weibo/api/v2/relationship"
require "tencent_weibo/api/v2/t_weibo"
require "tencent_weibo/strategy/auth_code"

if defined?(Rails)
  module TencentWeibo
    class Railtie < Rails::Railtie
      initializer "tencent_weibo" do
        ActiveSupport.on_load :action_controller do
          if Object.const_defined?("Devise") && Devise.omniauth_configs[:weibo]
            TencentWeibo::Config.api_key = Devise.omniauth_configs[:tencent_weibo].strategy.client_id
            TencentWeibo::Config.api_secret = Devise.omniauth_configs[:tencent_weibo].strategy.client_secret
          end
        end
      end
    end
  end
end
