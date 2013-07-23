#!/usr/bin/env ruby
require_relative '../common/subscriber'
require_relative '../common/config'
require_relative 'bootstrap'

case ARGV[0]
when "run"
  Subscriber.new(Daemons.config['sqs']['ec2_queue_booted'], Daemons::Bootstrap.new)
end
