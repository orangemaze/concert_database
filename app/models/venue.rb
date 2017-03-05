class Venue < ActiveRecord::Base
  self.table_name = 'venue'
  has_many :concert_venues, :primary_key => 'venue_id', :foreign_key => 'venue_id'
  has_one :city, :primary_key => 'venue_city_id', :foreign_key => 'city_id'
  has_one :state, :primary_key => 'venue_state_id', :foreign_key => 'state_id'
  has_one :country, :primary_key => 'venue_country_id', :foreign_key => 'flags_id'
  has_many :venue_names, :primary_key => 'venue_id', :foreign_key => 'venue_id'
  has_many :concerts, :through => :concert_venues, :primary_key => 'concert_id', :foreign_key => 'concert_id'

  def venues_name
    venues_name = ''
    if venue_names.present?
      venue_names.each do |f|
	wiki = f.wiki.present? ? "<a href='https://en.wikipedia.org/wiki/#{f.wiki.to_s}' target='_blank'><i class='fa fa-wikipedia-w' aria-hidden='true'></i></a>" : ""

        venues_name = venues_name + "<tr><td>#{f.venue_name.to_s}</td>\n<td>#{f.start_date.to_s}</td>\n<td>#{f.end_date.to_s}</td>\n<td>#{f.notes.to_s}</td>\n<td>#{f.capacity.to_s}</td>\n<td>#{f.street.to_s}</td>\n<td>#{wiki}</td>\n<td>#{f.url.to_s}</td>\n</tr>\n"
      end
    end
    venues_name.html_safe
  end


  def city_name
    city.present? ? city.city_name.to_s : city.inspect
  end

  def state_name
    state.present? ? state.state_name.to_s : state.inspect
  end

  def state_abbr
    state.present? ? state.state_abbr.to_s : state.inspect
  end

  def country_id
    country.present? ? country.flags_id.to_s : country.inspect
  end

  def country_name
    country.present? ? country.country.to_s : country.inspect
  end

  def flag_location
    country.present? ? country.flag_location.to_s : country.inspect
  end

  def iso_codes
    country.present? ? country.iso_codes.to_s : country.inspect
  end
end
