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
        band_name = band_name.to_s + f.band_name.to_s + ' / ' + tour_name + '<ul>' + bands_members.to_s + '</ul>'
      end
    end
    band_name.html_safe
  end

  def tour_name
    tour_name = ''
    if  tours.present?
      tours.each do |f|
        tour_name = tour_name.to_s + f.tour_name.to_s + '<br>'
      end
    end
    tour_name.html_safe
  end

  def bands_members
    #TODO need to adjust the band order, via concert_band.band_position
    bands_members = ''
    if  bands.present?
      bands.each do |f|
         if  band_members.present?
           band_members.each do |g|
            if f.band_id == g.band_id
              bands_members = bands_members.to_s + '<li>' + g.bands_members.to_s + '</li>'
            end

          end
        end

      end
    end
    bands_members.html_safe
  end

  def band_id
    band_id = ''
    if  bands.present?
      bands.each do |f|
        band_id = band_id.to_s + f.band_id.to_s + '<br>'
      end
    end
    band_id.html_safe
  end



end