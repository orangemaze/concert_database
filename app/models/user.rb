class User < ActiveRecord::Base
  self.table_name = 'user'
  has_many :roios, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :reviews, :primary_key => 'username', :foreign_key => 'nick'


end