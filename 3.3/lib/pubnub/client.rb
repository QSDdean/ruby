require 'pubnub/em/client.rb'

module Pubnub
  class Client
    def initialize(options = {})
      options.each do |k,v|
        instance_variable_set(:"@#{k}", v)
      end
      @ssl          = @ssl ? true : false
      @session_uuid = generate_new_uuid

      validate_client
    end

    def publish(options = {})
      options.merge!(
        {
          :ssl           => @ssl,
          :cipher_key    => @cipher_key,
          :publish_key   => @publish_key,
          :subscribe_key => @subscribe_key,
          :secret_key    => @secret_key
        }
      )

      request = Pubnub::Request.new(options)
    end

    private

    def validate_client
      raise(InitError, 'subscribe_key is a mandatory parameter.') if @subscribe_key.to_s.size == 0
    end

    def generate_new_uuid
      UUID.new.generate
    end

    def connect
    end
  end
end
