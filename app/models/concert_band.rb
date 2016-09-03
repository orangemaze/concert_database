class ConcertBand < ActiveRecord::Base
  self.table_name = 'concert_band'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :tours, :primary_key => 'tours_id', :foreign_key => 'tours_id'
  has_many :band_members, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :roios, :through => :concerts, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'

  def concert_date
    concert_date = ''
    if  concerts.order('concert_date').present?
      concerts.each do |f|
        concert_date = concert_date.to_s + f.concert_date.to_s
      end
    end
    concert_date.html_safe
  end

  def concert_id
    concert_id = ''
    if  concerts.present?
      concerts.each do |f|
        concert_id = concert_id.to_s + f.concert_id.to_s
      end
    end
    concert_id.html_safe
  end

  def bootleg_name
    bootleg_name = ''
    if  roios.present?
      roios.each do |f|
        bootleg_name = bootleg_name.to_s + f.bootleg_name.to_s + "<br>"
      end
    end
    bootleg_name.html_safe
  end



  def band_details
    band_name = ''
    if  bands.present?
      bands.each do |f|
        band_name = "#{band_name.to_s}Band\n
<ul class='li-no-style'>\n
  <li><a href='/bands/#{f.band_id.to_s}'>#{f.band_name.to_s}</a></li>\n
  <li>Tour
    <ul class='li-no-style'>\n
      <li>#{tour_name}</li>\n
    </ul>\n
  </li>\n
  #{bands_members.to_s}</ul>\n
</ul>\n"
      end
    end
    band_name.html_safe
  end

  def tour_name
    tour_name = ''
    if  tours.order('start_date').present?
      tours.each do |f|
        tour_name = "#{tour_name.to_s} <a href='/tour/#{f.tours_id.to_s}'>#{f.tour_name.to_s}</a>"
      end
    end
    tour_name.html_safe
  end

  def tour_start_date
    tour_start_date = ''
    if  tours.present?
      tours.each do |f|
        tour_start_date = tour_start_date.to_s + f.start_date.to_s
      end
    end
    tour_start_date.html_safe
  end

  def tour_end_date
    tour_end_date = ''
    if  tours.present?
      tours.each do |f|
        tour_end_date = tour_end_date.to_s + f.end_date.to_s
      end
    end
    tour_end_date.html_safe
  end



  def bands_members
    bands_members = ''
    if  bands.present?
      bands.each do |f|
        if  band_members.present?
          band_members.each do |g|
            if f.band_id == g.band_id
              bands_members = "#{bands_members.to_s}<li>#{g.bands_members}</li>\n"
            end

          end
        end

      end
    end
    bands_members = ("<li>Members <ul class='li-no-style'>\n#{bands_members}</ul></li>\n").to_s
  end

  def band_id
    band_id = ''
    if  bands.present?
      bands.each do |f|
        band_id = band_id.to_s + f.band_id.to_s
      end
    end
    band_id.html_safe
  end

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