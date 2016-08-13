class Roio < ActiveRecord::Base
  self.table_name = 'bootlegs'
  belongs_to :concert, :foreign_key => 'concert_id'
  belongs_to :band, :foreign_key => 'band_id'
  has_many :concert_band, :through => :concert, :source => 'concert_bands', :primary_key => 'concert_id'
  has_one :user, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :roio_ratings, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'

  def concert_date
    concert.present? ? concert.concert_date.to_s : concert.inspect
  end

  def band_id
    concert.present? ? concert.band_id : concert.inspect
  end

  def venue_id
    concert.present? ? concert.venue_id : concert.inspect
  end

  def venue_name
    concert.present? ? concert.venue_name : concert.inspect
  end

  def band_name
    band.present? ? band.band_name : band.inspect
  end

  def user_name
    user.present? ? user.user_name : user.inspect
  end

  def band_details
    band_details = ''
    if  concert_band.present?
      concert_band.each do |f|
        band_details = band_details.to_s + f.band_details.to_s
      end
    end
    band_details.html_safe
  end

  def roio_avg_rating
    roio_avg_rating = ''
    if  roio_ratings.present?
      roio_ratings.each do |f|
        roio_avg_rating = roio_avg_rating.to_f + f.rating.to_f
      end
    end
    roio_avg_rating = roio_ratings.present? ? (roio_avg_rating.to_f / roio_ratings.count).to_i : 'no ratings'
  end

end