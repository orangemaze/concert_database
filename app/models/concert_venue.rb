class ConcertVenue < ActiveRecord::Base
  self.table_name = 'concert_venue'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :venues_names, :primary_key => 'venue_id', :foreign_key => 'venue_id'

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
          venue_name = @venue_name.to_s + ' / start_date:' + @start_date.to_s + ' / end_date:' + @end_date.to_s + '<br>'
        end
      end
    venue_name = venue_name
    end
  end
end