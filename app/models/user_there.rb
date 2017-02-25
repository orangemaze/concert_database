class UserThere < ActiveRecord::Base
  self.table_name = 'user_there'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :users, :primary_key => 'user_id', :foreign_key => 'user_id'

  def users_info
    users_info = users
  end


end
