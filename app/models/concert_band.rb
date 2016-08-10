class ConcertBand < ActiveRecord::Base
  self.table_name = 'concert_band'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :bands, :primary_key => 'band_id', :foreign_key => 'band_id'

  def band_name
    band_name = ''
    if  bands.present?
      bands.each do |f|
        band_name = band_name.to_s + f.band_name.to_s + '<br>'
      end
    end
    band_name = band_name.html_safe
  end
end