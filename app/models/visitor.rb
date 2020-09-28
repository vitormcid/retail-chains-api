class Visitor < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :chain
  has_one_attached :featured_image
  has_many :incidences
  validates :name, presence: true  

  settings do 
  	mappings dynamic: false do
  		indexes :name, type: :text
  	end
  end

  def self.search_by_name(var)
  	self.search( {"query": { "match_phrase": { "name": var } } } )
  end

end
