class Album < ActiveRecord::Base
  self.table_name = 'albums'
  has_many :album_tours, :primary_key => 'id', :foreign_key => 'album_id'
  has_many :band_albums, :primary_key => 'id', :foreign_key => 'album_id'
end
