class Country < ActiveRecord::Base
  self.table_name = 'flags'
  has_many :venues, :primary_key => 'flags_id', :foreign_key => 'venue_country_id'




end