class City < ActiveRecord::Base
  self.table_name = 'city'
  has_many :venues, :primary_key => 'city_id', :foreign_key => 'venue_city_id'
end