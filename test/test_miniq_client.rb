require 'minitest'
require 'minitest/autorun'
require 'minitest/benchmark'
require 'httpclient'
require 'multi_json'

load_arr = ["../lib/miniq_client.rb"]
load_arr.each do |lib|
        require File.expand_path(File.dirname(__FILE__)+"/"+lib)
end

class TestPostMessages < Minitest::Test
        def setup
        end

        def test_mini_client
		host = "localhost"
		port = "7777"
		queue_name = "test2"
		miniq_client = MiniQClient.new(host, port, queue_name)
		msg = "Stayzilla_test"
		
		id = miniq_client.add(msg)
		$log.info "id: #{id}"
		assert_equal(true, (id.is_a?String and not id.empty?))
		id = miniq_client.add(msg)
		$log.info "id: #{id}"
		assert_equal(true, (id.is_a?String and not id.empty?))
		
		messages = miniq_client.get
		$log.info "messages: #{messages}"
		assert_equal(true, (messages.is_a?Array and messages.size == 2 and messages[0].is_a?Hash))
		
		messages = miniq_client.get
		$log.info "messages: #{messages}"
		assert_equal(true, (messages.is_a?Array and messages.size == 0))
	end

end
