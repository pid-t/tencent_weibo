require 'hashie'
require 'json'
require 'net/http/post/multipart'

module TencentWeibo
  module Api
    module V2

      class Base
        extend Forwardable
        
        def_delegators :@access_token, :get, :post, :put, :delete
        
        @@api_version = "2.a"

        def initialize(access_token, open_id="", scope = 'all')
          @access_token = access_token
          @app_key = TencentWeibo::Config.api_key
          @app_secret = TencentWeibo::Config.api_secret
          @open_id = open_id
          @scope = scope
          @default_opt = {:oauth_consumer_key => @app_key ,:openid => @open_id,
                           :oauth_version => @@api_version, :scope => @scope,
                           :access_token =>@access_token.token }
        end

        def open_id=(val)
          @open_id = val
          @default_opt[:openid]=@open_id
        end

        def hashie(response)
          json_body = MultiJson.load(response.body)
          if json_body.is_a? Array
            Array.new(json_body.count){|i| Hashie::Mash.new(json_body[i])}
          else
            Hashie::Mash.new json_body
          end
        end

        def self.get_methods(*methods)
          methods.each do |method|
            define_method method do |opt={}|
              url = get_url_prefix()
              opt = get_opt opt
              Hashie get("#{url}/#{method}", :params => opt)
            end
          end
        end

        def self.post_methods(*methods)
          methods.each do |method|
            define_method method do |opt={}|
              url = get_url_prefix
              opt = get_opt opt
              Hashie post("#{url}/#{method}", :body => opt)
            end
          end
        end

        protected

        def get_opt(opt={})
          # add default oauth params
          unless opt.has_key? :clientip
            raise Error.new("parameter clientip is required.")
          end
          @default_opt.merge(opt)
        end

        def mime_type(file)
          case
            when file =~ /\.jpeg$/i then 'image/jpeg'
            when file =~ /\.jpg$/i then 'image/jpeg'
            when file =~ /\.gif$/i then 'image/gif'
            when file =~ /\.png$/i then 'image/png'
            when file =~ /\.tiff$/i then 'image/tiff'
            else 'image/jpeg'
          end
        end

        def bin_encode(chunk)
          chunk.force_encoding(Encoding::BINARY) if chunk.respond_to? :force_encoding
        end
        
        CRLF = "\r\n"
        def build_multipart_bodies(parts, opts)
          boundary = Time.now.to_i.to_s(16)

          body = bin_encode('')

          parts.each do |key, value|
            esc_key = CGI.escape(key.to_s)
            body << bin_encode("--#{boundary}#{CRLF}")
            if value.respond_to?(:read)
              filename = opts.delete(:filename) || File.basename(value.path)
              mime_type = opts.delete(:type) || mime_type(value.path)

              body << bin_encode("Content-Disposition: form-data; name=\"#{esc_key}\"; filename=\"#{filename}\"#{CRLF}")
              body << bin_encode("Content-Type: #{mime_type}#{CRLF}")
              body << bin_encode("Content-Transfer-Encoding: binary#{CRLF*2}")
              body << bin_encode(value.read)
            else
              body << bin_encode("Content-Disposition: form-data; name=\"#{esc_key}\"#{CRLF*2}#{value}")
            end
            body << bin_encode(CRLF)

          end 

          body << bin_encode("--#{boundary}--#{CRLF*2}")

          {
            :body => body,
            :headers => {"Content-Type" => "multipart/form-data; boundary=#{boundary}"}
          }
        end
        
      end
    end
  end
end