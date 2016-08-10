class State < ActiveRecord::Base
  self.table_name = 'states'
  has_many :venues, :primary_key => 'state_id', :foreign_key => 'venue_state_id'




end