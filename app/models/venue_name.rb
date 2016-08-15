class VenueName < ActiveRecord::Base
  self.table_name = 'venue_names'
  has_many :concert_names, :foreign_key => 'venue_id'
  has_many :countries, :through => :venues, :primary_key => 'venue_id', :foreign_key => 'venue_id'
end