# miniq_client: This is MiniQ client in Ruby.

Overview
========
Have a look at Amazon's Simple Queuing System: http://goo.gl/Bn8qaD . MiniQ is similar, but simpler system. It is a broker that allows multiple producers to write to it, and multiple consumers to read from it. It runs on a single server. Whenever a producer writes to MiniQ, a message ID is generated and returned as confirmation. Whenever a consumer polls MiniQ for new messages, it gets those messages which are NOT processed by any other consumer that may be concurrently accessing MiniQ. NOTE that, when a consumer gets a set of messages, it must notify MiniQ that it has processed each message (individually). This deletes that message from the MiniQ database. If a message is received by a consumer, but NOT marked as processed within a configurable amount of time, the message then becomes available to any consumer requesting again.

Method specification
====================

This is ruby client. It support following methods:

 - `initialize(host, port, queue_name, args_hash = {})` - Initializing miniq client.
	# @param [String] host miniq server host
        # @param [String] port miniq server port
        # @param [String] queue name
        # @param [Hash] args_hash 
        # @retrun [MiniQClient]
 - `add(msg)` - This implemets producer. This add a message into a queue
        # @param [String] msg message to be added
        # @return [String, nil] message id generated 
 - `get()` - This implemets consumer. This gets messages to be processed
	# @retrun [Array] an array of messages


Setup and build details
=======================

------

## Language 

Ruby version - 2.3.1

------

## Getting started

1) Clone or download this repository

~~~
$ git clone https://github.com/ghoshpulak91/miniq_client.git
$ cd miniq_client
~~~

2) Install prerequisites and setting up environment.

2.1) Install mongodb(Ref: https://docs.mongodb.com/manual/installation/).

2.2) Install RVM and Ruby-2.3.1(Ref: http://tecadmin.net/install-ruby-on-rails-on-ubuntu/)

2.3) Set ruby-2.3.1 as default ruby version. 

~~~
$ rvm use 2.3.1 --default
$ ruby --version
~~~


2.4) Install required gems 

~~~ 
$ gem install bundler json multi_json logger httpclient minitest 
~~~

------

## Run test suite 

To run the test suite 

~~~
$ ruby ./test/test_miniq_client.rb
~~~ 

## How to use

To use this 

~~~
require_relative "../lib/miniq_client.rb"
host = "localhost"
port = "7777"
queue_name = "test2"
miniq_client = MiniQClient.new(host, port, queue_name)
msg = "Stayzilla_test"
id = miniq_client.add(msg)
$log.info "id: #{id}"
messages = miniq_client.get
$log.info "messages: #{messages}"
~~~
