class Chain < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, presence:true
  validates_cnpj :cnpj

  settings do 
  	mappings dynamic: false do
  		indexes :name, type: :text
  	end
  end

  def self.search_by_name(var)
  	self.search( {"query": { "match_phrase": { "name": var } } } )
  end

end
