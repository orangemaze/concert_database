class Moderator < ActiveRecord::Base
  self.table_name = 'moderators'
  has_many :users, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :bands, :foreign_key => 'band_id', :primary_key => 'band_id'

  def band_name
    band_name = ''
    if  bands.present?
      bands.each do |f|
        band_name = band_name.to_s + f.band_name.to_s
      end
    end
    band_name.html_safe
  end


end