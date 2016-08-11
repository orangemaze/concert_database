class VenuesName < ActiveRecord::Base
  self.table_name = 'venue_names'
  has_many :concert_names, :foreign_key => 'venue_id'
end