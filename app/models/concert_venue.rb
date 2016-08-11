class ConcertVenue < ActiveRecord::Base
  self.table_name = 'concert_venue'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :venues_names, :primary_key => 'venue_id', :foreign_key => 'venue_id'
  has_one :venue, :primary_key => 'venue_id', :foreign_key => 'venue_id'

  def venue_name

    venue_name = ''

    if  concerts.present?
      concerts.each do |f|
        @concert_date = ApplicationController.helpers.fix_bad_dates_in_db(f.concert_date)
      end
    end

    if venues_names.present?
      venues_names.each do |f|
        @venue_name = f.venue_name
        @start_date = ApplicationController.helpers.fix_bad_dates_in_db(f.start_date)
        @end_date = ApplicationController.helpers.fix_bad_dates_in_db(f.end_date)

        if (@start_date.to_s..@end_date.to_s).cover?(@concert_date)
          venue_name = @venue_name.to_s + ', ' + city_name.to_s + ', ' + state_name.to_s + ' (' + state_abbr.to_s + '), ' + country_name.to_s + '<a href="index.php?list=country&amp;choice='+country_name.to_s+'" class="flag flags flag-'+iso_codes.downcase.to_s+'" title="'+country_name.to_s+'">&nbsp;</a>'
        end
      end
    venue_name.html_safe
    end
  end

  def city_id
    venue.present? ? venue.venue_city_id.to_s : venue.inspect
  end

  def city_name
    venue.present? ? venue.city_name.to_s : venue.inspect
  end

  def state_name
    venue.present? ? venue.state_name.to_s : venue.inspect
  end

  def state_abbr
    venue.present? ? venue.state_abbr.to_s : venue.inspect
  end

  def country_name
    venue.present? ? venue.country_name.to_s : venue.inspect
  end

  def flag_location
    venue.present? ? venue.flag_location.to_s : venue.inspect
  end

  def iso_codes
    venue.present? ? venue.iso_codes.to_s : venue.inspect
  end
end