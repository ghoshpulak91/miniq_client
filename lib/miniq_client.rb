require 'httpclient'
require 'multi_json'
require 'json'

load_arr = ["./logger.rb"]
load_arr.each do |lib|
	require File.expand_path(File.dirname(__FILE__)+"/"+lib)
end

class MiniQClient

	def initialize(host, port, queue_name, args_hash = {})
		@base_url = "http://#{host}:#{port}/messages/#{queue_name}"
		@httpclint = HTTPClient.new
	end
	
	# This method implemets 'DELETE /messages/{id}' endpoint
	# @param [Hash] params request parameter hash. Key is 'id'
	# @return [Hash] return a response_hash. Keys are status, content_type and body.
	def add(msg)
		begin
			header = {"Content-Type" => "application/json"}
			json_data = {"msg" => msg}.to_json
			response = @httpclint.post(@base_url, json_data, header)
			status_code = response.status
			# check status code
			raise Exception.new("could not write message to MiniQ, status_code: #{status_code}") if not(status_code and status_code == 201)
			body = response.body
			message_info_hash = MultiJson.load(body)
			id = message_info_hash["id"]
			# check message id 
			raise Exception.new("could not write message to MiniQ, message id: #{id}") if not id or id.empty?
			return id
		rescue Exception => e
			$log.error "#{e.class} -> #{e.message} for message #{msg}"
			$log.info e.backtrace
			return nil
		end
	end
	
	def get()
		messages = []
		begin
			response = @httpclint.get(@base_url)
			status_code = response.status
			# check status code
			raise Exception.new("could not get messages from MiniQ, status_code: #{status_code}") if not(status_code and status_code == 200)
			body = response.body
			messages = MultiJson.load(body)
			raise Exception.new("invalid messages #{messages}") if not messages.is_a?Array
			messages.each do |message|
				id = message["id"]
				notify(id)
			end
			return messages
		rescue Exception => e
			$log.error "#{e.class} -> #{e.message}"
			$log.info e.backtrace
			return nil
		end
	end

	private	
	def notify(id)
		begin
			url = @base_url + "/" + id 
			response = @httpclint.delete(url)
			status_code = response.status
			raise Exception.new("could not notify for id: #{id}") if not (status_code and status_code == 200)
			return true
		rescue Exception => e
			$log.error "#{e.class} -> #{e.message} for params #{params}"
			$log.info e.backtrace
			return true
		end
	end
end
