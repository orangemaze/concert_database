class Country < ActiveRecord::Base
  self.table_name = 'flags'
  has_many :venues, :primary_key => 'flags_id', :foreign_key => 'venue_country_id'
  has_many :venue_names, :through => :venues, :primary_key => 'flags_id', :foreign_key => 'venue_country_id'
  has_many :concert_venues, :through => :venues, :primary_key => 'flags_id', :foreign_key => 'venue_country_id'

  def venue_name
    venue_name = concert_venue.present? ? concert_venue.venue_name : concert_venue.inspect
  end


end