class Member < ActiveRecord::Base
  self.table_name = 'members'
  has_many :band_members, :primary_key => 'member_id', :foreign_key => 'member_id'

end