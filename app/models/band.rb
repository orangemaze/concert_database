class Band < ActiveRecord::Base
  self.table_name = 'band'
  has_many :concert_bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_one :roio, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :band_members, :primary_key => 'band_id', :foreign_key => 'band_id'
end