module Wonga
  module Daemon
    class PantryEC2BootedEventHandler
      def initialize(api_client, logger)
        @api_client = api_client
        @logger = logger
      end

      def handle_message(message)
        @logger.info "Updating booted status for Request:#{message["pantry_request_id"]}, Name:#{message["instance_name"]}, InstanceID:#{message["instance_id"]}"
        @api_client.send_put_request("/api/ec2_instances/#{message["pantry_request_id"]}", { booted: true, instance_id: message["instance_id"]})
        @logger.info "Updating booted status for Request:#{message["pantry_request_id"]} succeeded"
      end
    end
  end
end
