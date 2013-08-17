require 'oauth2'

module TencentWeibo
  class Client < OAuth2::Client

    attr_accessor :access_token
    
    def initialize(client_id='', client_secret='', opts={}, &block)
      client_id = TencentWeibo::Config.api_key if client_id.empty?
      client_secret = TencentWeibo::Config.api_secret if client_secret.empty?
      super
      @site = "https://open.t.qq.com/api"
      @options[:authorize_url] = '/cgi-bin/oauth2/authorize'
      @options[:token_url] = '/cgi-bin/oauth2/access_token'
    end

    def self.from_code(code, opts={}, &block)
      client = self.new(opts, &block)
      client.auth_code.get_token(code)

      client
    end

    def self.from_hash(hash, opts={}, &block)
      client = self.new(opts, &block)
      client.get_token_from_hash(hash)

      client
    end    

    def authorize_url(params={})
      params[:client_id] = @id unless params[:client_id]
      params[:response_type] = 'code' unless params[:response_type]
      params[:redirect_uri] = TencentWeibo::Config.redirect_uri unless params[:redirect_uri]
      super
    end
    
    def get_token(params, access_token_opts={})
      params = params.merge({:parse => :json})
      access_token_opts = access_token_opts.merge({:header_format => "OAuth2 %s",
                                                   :param_name => "access_token"})
      super
    end
    
    def get_and_restore_token(params, access_token_opts={})
      @access_token = get_token(params, access_token_opts={})
    end
    
    def get_token_from_hash(hash)
      access_token = hash.delete(:access_token) || hash.delete('access_token')
      @access_token = TencentWeibo::AccessToken.new( self,
                                                     access_token, hash.merge(:header_format => 'OAuth2 %s',
                                                                              :param_name => 'access_token') )
    end
    
    def authorized?
      @access_token && @access_token.validated?
    end

    def friendships
      @friendships ||= TencentWeibo::Api::V2::Friendships.new(@access_token) if @access_token
    end

    def t_weibo
      @t_weibo ||= TencentWeibo::Api::V2::TWeibo.new(@access_token) if @access_token
    end

    def auth_code
      @auth_code ||= TencentWeibo::Strategy::AuthCode.new(self)
    end

  end 
end
