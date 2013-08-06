require 'json'
require 'timeout'
require 'rest_client'
module Daemons
  class EC2BootedEventHandler

    def initialize(config)
      @config = config
    end

    def handle_message(message)
      puts message
      url = @config["pantry"]["url"]
      msg_json = JSON.parse(message["Message"])
      request_id = msg_json['pantry_request_id']
      request_url = "#{url}/aws/ec2_instances/#{request_id}"
      puts request_url
      update = ({:booted=>true,:instance_id=>msg_json["instance_id"]}).to_json
      puts "#{update}"
      Timeout::timeout(@config['pantry']['timeout']){
        RestClient.put request_url, update, {:content_type => :json, :'x-auth-token' => @config['pantry']['api_key'] }
      }
    end

  end
end

