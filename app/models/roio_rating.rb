class RoioRating < ActiveRecord::Base
  self.table_name = 'ratings'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'

end