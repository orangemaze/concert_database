class UserTradeList < ActiveRecord::Base
  self.table_name = 'user_trade_list'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :users, :primary_key => 'user_id', :foreign_key => 'user_id'

end