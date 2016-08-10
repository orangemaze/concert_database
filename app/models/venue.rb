class Venue < ActiveRecord::Base
  self.table_name = 'venue'
  has_many :concert_venues, :primary_key => 'venue_id', :foreign_key => 'venue_id'

end