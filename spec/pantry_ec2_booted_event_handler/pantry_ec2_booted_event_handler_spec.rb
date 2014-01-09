require 'spec_helper'
require_relative "../../pantry_ec2_booted_event_handler/pantry_ec2_booted_event_handler"

describe Wonga::Daemon::PantryEC2BootedEventHandler do
  let(:api_client) { instance_double('Wonga::Daemon::PantryApiClient') }
  let(:logger) { instance_double('Logger').as_null_object }
  subject { described_class.new(api_client, logger) }
  let(:message) { { "user_id"  => 1, "pantry_request_id" => 40, "instance_id" => "i-0123abcd", "private_ip" => "999.999.0.1"} }
  it_behaves_like "handler"

  it "updates Pantry using PantryApiClient" do
    expect(api_client).to receive(:send_put_request).with(
      "/api/ec2_instances/40",
      { "user_id" => 1, "pantry_request_id" => 40, "instance_id" => "i-0123abcd", "private_ip" => "999.999.0.1", :booted => true }
    )
    subject.handle_message(message)
  end
end
