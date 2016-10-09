require 'logger'
require 'fileutils' 

load_arr = []
load_arr.each do |lib|
	require File.expand_path(File.dirname(__FILE__)+"/"+lib)
end

# Create a logger which logs messages to STDERR
$log ||= Logger.new(STDERR)
# Log level is INFO
$log.level = Logger::INFO
