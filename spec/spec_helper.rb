require 'rspec'
require 'dm-core/spec/setup'
require 'dm-core/spec/lib/adapter_helpers'

require 'dm-is-read_only'
require 'classes/backend_model'
require 'classes/read_only_model'
require 'classes/related_model'

DataMapper::Spec.setup

RSpec.configure do |config|
  config.extend(DataMapper::Spec::Adapters::Helpers)

  config.before(:suite) do
    DataMapper.finalize
    BackendModel.auto_migrate!

    ('a'..'z').each do |value|
      BackendModel.create(:value => value)
    end
  end
end
