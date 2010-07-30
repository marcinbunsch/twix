module Twix
  class OAuth
    include Singleton
    attr_accessor :consumer_token, :consumer_secret

    def initialize
      @config = Twix::Config.instance.data
      @consumer_token = @config[:consumer_token]
      @consumer_secret = @config[:consumer_secret]
      @pin = @config[:pin]
    end

    def consumer
      ::OAuth::Consumer.new(
        @consumer_token,
        @consumer_secret,
        {:site => "http://twitter.com"}
      )
    end

    def request_token
      @request_token ||= consumer.get_request_token
    end

    def access_tokens(pin)
      tokens = request_token.get_access_token(:oauth_verifier => pin)
    end

    def access_token(token_hash)
      access_token ||= ::OAuth::AccessToken.from_hash(consumer, token_hash)
    end

    def authorize_url
      request_token.authorize_url
    end

    def token_hash
      { :oauth_token => @config[:oauth_token], 
        :oauth_token_secret => @config[:oauth_token_secret] }
    end

  end
end
