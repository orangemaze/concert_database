class User < ActiveRecord::Base
  self.table_name = 'user'
  has_many :roios, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :reviews, :primary_key => 'username', :foreign_key => 'nick'
  has_many :moderators, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :bands, :through => :moderators, :primary_key => 'band_id', :foreign_key => 'band_id'


  def band_name
    band_name = ''
    if bands.present?
      bands.order('band_position').each do |f|
        band_name = band_name + f.band_details.to_s
      end
    end
    band_name.html_safe
  end

end