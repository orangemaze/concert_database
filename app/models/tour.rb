class Tour < ActiveRecord::Base
  self.table_name = 'tours'
  has_many :concert_bands, :primary_key => 'tours_id', :foreign_key => 'tours_id'
  has_many :bands, :primary_key => 'band_id', :foreign_key => 'band_id'

  def tour_dates
    tour_dates = ''
    if  concert_bands.present?
      concert_bands.each do |f|
        tour_dates = "#{tour_dates.to_s} <li><a href='/tour/#{f.concert_id}'>#{f.concert_date}</a></li>\n"
      end
    end
    tour_dates.html_safe
  end


end