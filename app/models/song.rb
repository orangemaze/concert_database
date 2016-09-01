class Song < ActiveRecord::Base
  self.table_name = 'songs'
  has_many :roio_set_lists, :primary_key => 'songs_id', :foreign_key => 'songs_id'

end