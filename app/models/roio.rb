class Roio < ActiveRecord::Base
  self.table_name = 'bootlegs'
  belongs_to :concert, :foreign_key => 'concert_id'
  belongs_to :band, :foreign_key => 'band_id'
  has_many :concert_band, :through => :concert, :source => 'concert_bands', :primary_key => 'concert_id'
  has_one :user, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :roio_ratings, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :images, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :reviews, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :roio_set_lists, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :songs, :through => :roio_set_lists, :primary_key => 'songs_id', :foreign_key => 'songs_id'
  has_many :user_trade_lists, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'

  def concert_date
    concert.present? ? concert.concert_date.to_s : concert.inspect
  end

  def band_id
    band.present? ? band.band_id : band.inspect
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

  def roio_set_list
    roio_set_list = Hash.new
    if  roio_set_lists.present?
      roio_set_lists.order('set_position').each do |f|
        roio_set_list[f.roio_set_list_id] = "#{f.set_position} <a href='/song/#{f.songs_id}'> #{f.song_name.to_s} </a>"
      end
    end
    roio_set_list
  end


  def user_trade_list
    user_trade_list = Hash.new
    if  user_trade_lists.present?
      user_trade_lists.each do |f|
        user_trade_list[f.user_id] = "#{f.time_entered}"
      end
    end
    user_trade_list
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
    begin
      roio_avg_rating = ''
      if  roio_ratings.present?
        roio_ratings.each do |f|
          roio_avg_rating = roio_avg_rating.to_f + f.rating.to_f
        end
      end
      roio_avg_rating = roio_ratings.present? ? (roio_avg_rating.to_f / roio_ratings.count).to_i : 'no ratings'
    rescue
      roio_avg_rating = ''
    end
  end

  def roio_image_count
    images.count
  end

end