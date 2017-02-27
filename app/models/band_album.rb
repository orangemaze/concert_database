class BandAlbum < ActiveRecord::Base
  self.table_name = 'band_albums'
  has_many :bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :albums, :primary_key => 'album_id', :foreign_key => 'id'


  def band
    bands.first
  end

  def album
    albums.first
  end

end
