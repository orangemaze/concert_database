class UserImage < ActiveRecord::Base
  self.table_name = 'user_image'
  has_many :users, :foreign_key => 'user_id', :primary_key => 'user_id'

end
