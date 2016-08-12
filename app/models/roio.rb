class Roio < ActiveRecord::Base
  self.table_name = 'bootlegs'
  belongs_to :concert, :foreign_key => 'concert_id'
  belongs_to :band, :foreign_key => 'band_id'


  def concert_date
    concert.present? ? concert.concert_date.to_s : concert.inspect
  end

  def band_id
    concert.present? ? concert.band_id : concert.inspect
  end

  def venue_id
    concert.venue_id
  end

  def venue_name
    concert.venue_name
  end

  def band_name
    band.band_name
  end
end