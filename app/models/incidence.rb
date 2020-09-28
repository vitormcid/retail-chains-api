class Incidence < ApplicationRecord
  extend Enumerize
  enumerize :kind, in: [:entry, :exit]
end
