require 'json'
require 'rest_client'
module Daemons
  class EC2BootedEventHandler

    def initialize(config)
      @config = config
    end

    def handle_message(message)
      base_url = @config["pantry"]["url"]
      request_id = message["pantry_request_id"]
      update = ({:booted=>true,:instance_id=>message["instance_id"]}).to_json
      site = RestClient::Resource.new("#{base_url}",:timeout => @config["pantry"]["request_timeout"])
      site["/aws/ec2_instances/#{request_id}"].put update, {:accept => :json, :content_type => :json, :'x-auth-token' => @config["pantry"]["api_key"] }
    end

  end
end

