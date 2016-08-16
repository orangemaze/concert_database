class Band < ActiveRecord::Base
  self.table_name = 'band'
  has_many :concert_bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_one :roio, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :band_members, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :tours, :primary_key => 'band_id', :foreign_key => 'band_id'

  def tour_name
    tour_name = ''
    if  tours.present?
      tours.order('start_date').each do |f|
        tour_name = "#{tour_name.to_s} <li><a href='/tour/#{f.tours_id}'>#{f.tour_name.to_s} (#{ApplicationController.helpers.fix_bad_dates_in_db(f.start_date)} - #{ApplicationController.helpers.fix_bad_dates_in_db(f.end_date)})</a></li>"
      end
    end
    tour_name.html_safe
  end

end