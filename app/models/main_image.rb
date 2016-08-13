class MainImage < ActiveRecord::Base
  self.table_name = 'main_images'
  has_many :users, :primary_key => 'user_id', :foreign_key => 'user_id'




end