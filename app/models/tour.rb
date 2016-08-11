class Tour < ActiveRecord::Base
  self.table_name = 'tours'
  has_many :concert_bands, :primary_key => 'tours_id', :foreign_key => 'tours_id'




end