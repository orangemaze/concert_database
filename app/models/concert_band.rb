class ConcertBand < ActiveRecord::Base
  self.table_name = 'concert_band'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  belongs_to :band, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :tours, :primary_key => 'tours_id', :foreign_key => 'tours_id'
  has_many :band_members, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :roios, :through => :concerts, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'

  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

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
    if  band.present?
      #band.each do |f|
      puts 'um here?'.green
      puts band.inspect.magenta
      puts band['band_id']
        band_name = "#{band['band_name'].to_s}Band\n
<ul class='li-no-style'>\n
  <li>#{link_to band['band_name'].to_s, bands_path(band['band_id'])}</li>\n
  <li>Tour
    <ul class='li-no-style'>\n
      <li>#{tour_name}</li>\n
    </ul>\n
  </li>\n
  #{bands_members.to_s}</ul>\n
</ul>\n"
      #end
    end
    band_name.html_safe
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
    if  band.present?
        if  band_members.present?
          band_members.each do |g|
            if band['band_id'] == g.band_id
              bands_members = "#{bands_members.to_s}<li>#{g.bands_members}</li>\n"
            end

          end
        end


    end
    bands_members = ("<li>Members <ul class='li-no-style'>\n#{bands_members}</ul></li>\n").to_s
  end

  def band_id
    band_id = ''
    if  band.present?
      #band.each do |f|
        band_id = band_id.to_s
      #end
    end
    band_id.html_safe
  end

  def band_name
    band_name = Hash.new
    if  band.present?
      #band.each do |f|
        band_name[band['band_id']] = band['band_name'].to_s
      #end
    end
    band_name
  end

  def tour_name
    tour_name = Hash.new
    if  tours.order('start_date').present?
      tours.each do |f|
        tour_name[f.tours_id] = f.tour_name.to_s
      end
    end
    tour_name
  end

end