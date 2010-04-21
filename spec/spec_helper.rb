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
require 'dm-core/spec/lib/spec_helper'
require 'dm-core/spec/lib/adapter_helpers'

ENV['ADAPTERS'] ||= 'sqlite3'

# create sqlite3_fs directory if it doesn't exist
temp_db_dir = Pathname(File.expand_path('../db', __FILE__))
temp_db_dir.mkpath

DataMapper::Spec::AdapterHelpers.temp_db_dir = temp_db_dir

adapters = ENV['ADAPTERS'].split(/\s+/).map { |adapter_name| adapter_name.downcase }.uniq
adapters = DataMapper::Spec::AdapterHelpers.primary_adapters.keys if adapters.include?('all')

DataMapper::Spec::AdapterHelpers.setup_adapters(adapters)

Spec::Runner.configure do |config|
  config.extend(DataMapper::Spec::AdapterHelpers)

  config.after :all do
    DataMapper::Spec.cleanup_models
  end
end
