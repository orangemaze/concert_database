class RoioRating < ActiveRecord::Base
  self.table_name = 'ratings'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :users, :primary_key => 'user_id', :foreign_key => 'user_id'
end
