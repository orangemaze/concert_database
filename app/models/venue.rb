class Venue < ActiveRecord::Base
  self.table_name = 'venue'
  has_many :concert_venues, :primary_key => 'venue_id', :foreign_key => 'venue_id'
  has_one :city, :primary_key => 'venue_city_id', :foreign_key => 'city_id'
  has_one :state, :primary_key => 'venue_state_id', :foreign_key => 'state_id'
  has_one :country, :primary_key => 'venue_country_id', :foreign_key => 'flags_id'

  def city_name
    city_name = city.present? ? city.city_name.to_s : city.inspect
  end

  def state_name
    state_name = state.present? ? state.state_name.to_s : state.inspect
  end

  def state_abbr
    state_abbr = state.present? ? state.state_abbr.to_s : state.inspect
  end

  def country_name
    country_name = country.present? ? country.country.to_s : country.inspect
  end

  def flag_location
    flag_location = country.present? ? country.flag_location.to_s : country.inspect
  end

  def iso_codes
    iso_codes = country.present? ? country.iso_codes.to_s : country.inspect
  end
end