class ConcertRating < ActiveRecord::Base
  self.table_name = 'ratingsconcerts'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'

end