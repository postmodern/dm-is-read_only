require 'dm-core'
require 'dm-is-read_only'

class ReadOnlyModel

  include DataMapper::Resource

  storage_names[:default] = 'shared_table'

  is :read_only

  property :id, Serial

  property :value, String

  has 0..n, :related_models

end
