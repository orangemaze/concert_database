class Song < ActiveRecord::Base
  self.table_name = 'songs'
  has_many :roio_set_lists, :primary_key => 'songs_id', :foreign_key => 'songs_id'
  has_many :roios, :through => :roio_set_lists, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :concerts, :through => :roio_set_lists, :primary_key => 'concert_id', :foreign_key => 'concert_id'
end
