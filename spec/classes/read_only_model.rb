require 'dm-core'

class ReadOnlyModel

  include DataMapper::Resource

  storage_names[:default] = 'shared_table'

  is :read_only

  property :id, Serial

  property :value, String

end
