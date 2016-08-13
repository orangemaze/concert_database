class Image < ActiveRecord::Base
  self.table_name = 'images'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'


end