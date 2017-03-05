class RoioSetList < ActiveRecord::Base
  self.table_name = 'roio_set_list'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :songs, :primary_key => 'songs_id', :foreign_key => 'songs_id'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'

  def song_name
    song_name = Array.new
    if  songs.present?
      songs.each do |f|
        song_name = "#{f.song_name.to_s}"
      end
    end
    song_name
  end

end
