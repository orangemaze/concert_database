class Member < ActiveRecord::Base
  self.table_name = 'members'
  has_many :band_members, :primary_key => 'member_id', :foreign_key => 'member_id'

  def band_name
    band_name = Hash.new
    puts '-- member --'.red

    band_name
  end



end