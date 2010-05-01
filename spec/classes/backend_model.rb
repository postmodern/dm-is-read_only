require 'dm-core'
require 'dm-migrations'

class BackendModel

  include DataMapper::Resource
  include DataMapper::Migrations

  storage_names[:default] = 'shared_table'

  property :id, Serial

  property :value, String

end
