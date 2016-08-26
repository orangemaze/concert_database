class AlbumTour < ActiveRecord::Base
  self.table_name = 'album_tours'
  has_many :albums, :primary_key => 'album_id', :foreign_key => 'id'
  has_many :tours, :primary_key => 'tour_id', :foreign_key => 'tour_id'

end