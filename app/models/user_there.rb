class UserThere < ActiveRecord::Base
  self.table_name = 'user_there'
  self.primary_key = 'user_there_id'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :users, :primary_key => 'user_id', :foreign_key => 'user_id'
  has_many :bands, :through => :concerts, :primary_key => 'band_id', :foreign_key => 'band_id'

  def user
    user = users.first
    #puts users.first.inspect.blue
  end

  def concert
     concert = concerts.first
  end

  def band
    band = bands.first  
  end

end
