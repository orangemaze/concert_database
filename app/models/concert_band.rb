class ConcertBand < ActiveRecord::Base
  self.table_name = 'concert_band'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :tours, :primary_key => 'tours_id', :foreign_key => 'tours_id'
  has_many :band_members, :primary_key => 'concert_id', :foreign_key => 'concert_id'

  def band_name
    band_name = ''
    if  bands.present?
      bands.each do |f|
        band_name = band_name.to_s + f.band_name.to_s + ' / ' + tour_name + '<br>' + '<ul>' + bands_members.to_s + '</ul>'
      end
    end
    band_name = band_name.html_safe
  end

  def tour_name
    tour_name = ''
    if  tours.present?
      tours.each do |f|
        tour_name = tour_name.to_s + f.tour_name.to_s + '<br>'
      end
    end
    tour_name = tour_name.html_safe
  end

  def bands_members
    bands_members = ''
    if  band_members.present?
      band_members.each do |f|
        bands_members = bands_members.to_s + f.bands_members.to_s + '<br>'
      end
    end
    bands_members = bands_members.html_safe
  end


end