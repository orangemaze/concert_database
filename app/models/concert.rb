class Concert < ActiveRecord::Base
  self.table_name = 'concerts'
  has_many :roios, :primary_key => 'concert_id'
  belongs_to :concert_venue, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :band_members, :primary_key => 'concert_id', :foreign_key => 'concert_id'

  def this_test
    this_test = 'this test'
  end

  def bootleg_name
    if roios.present?
      data_holder = ''
      roios.each do |f|
        bootleg_name = f.bootleg_name
        roio_type = f.roio_type
        roio_format = f.roio_format
        band_name = f.band_name
        data_holder = data_holder.to_s +  + band_name.to_s + ' / ' + bootleg_name.to_s + ' / ' + roio_type.to_s + ' / ' + roio_format.to_s + '<br>'
      end
      bootleg_name = data_holder.html_safe
    end
  end


  def venue_id
    venue_id = concert_venue.present? ? concert_venue.venue_id : concert_venue.inspect
  end

  def venue_name
    venue_name = concert_venue.present? ? concert_venue.venue_name : concert_venue.inspect
  end

  def band_id
    band_id = ''
    if concert_bands.present?
      concert_bands.each do |f|
        band_id = band_id + f.band_id.to_s + '<br>'
      end
    end
    band_id = band_id.html_safe
  end


  def band_name
    band_name = ''
    if concert_bands.present?
      concert_bands.each do |f|
        band_name = band_name + f.band_name.to_s
      end
    end
    band_name = band_name.html_safe
  end

  def tour_name
    tour_name = ''
    if concert_bands.present?
      concert_bands.each do |f|
        tour_name = tour_name + f.tour_name.to_s
      end
    end
    tour_name = tour_name.html_safe
  end

end