require 'dm-core'
require 'dm-is-read_only/is/read_only'

DataMapper::Model.append_extensions DataMapper::Is::ReadOnly
