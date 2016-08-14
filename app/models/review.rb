class Review < ActiveRecord::Base
  self.table_name = 'reviews'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :users, :primary_key => 'nick', :foreign_key => 'username'



end