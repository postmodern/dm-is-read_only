require 'classes/read_only_model'

class RelatedModel

  include DataMapper::Resource

  property :id, Serial

  belongs_to :read_only_model

end
