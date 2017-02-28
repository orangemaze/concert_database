class Image < ActiveRecord::Base
  self.table_name = 'images'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :image_types, :primary_key => 'image_type', :foreign_key => 'image_type'

end
