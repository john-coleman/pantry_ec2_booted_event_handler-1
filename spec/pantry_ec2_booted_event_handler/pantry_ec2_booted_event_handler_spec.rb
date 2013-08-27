require 'spec_helper'
require_relative "../../pantry_ec2_booted_event_handler/pantry_ec2_booted_event_handler"

describe Wonga::Daemon::PantryEC2BootedEventHandler do
  let(:api_client) { instance_double('Wonga::Daemon::PantryApiClient').as_null_object }
  let(:logger) { instance_double('Logger').as_null_object }
  subject { described_class.new(api_client, logger) }
  let(:message) { { "pantry_request_id"=>40, "instance_id"=>"i-0123abcd" } }
  it_behaves_like "handler"

  it "updates Pantry using PantryApiClient" do
    expect(api_client).to receive(:update_ec2_instance).with(40, { instance_id: "i-0123abcd", booted: true })
    subject.handle_message(message)
  end
end
