require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:runtime, :test)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'spec'
require 'dm-core/spec/setup'
require 'dm-is-read_only'
