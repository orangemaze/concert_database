class Tour < ActiveRecord::Base
  self.table_name = 'tours'
  has_many :concert_bands, :primary_key => 'tours_id', :foreign_key => 'tours_id'
  has_many :bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :concerts, :through => :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :album_tours, :primary_key => 'tours_id', :foreign_key => 'tour_id'
  has_many :albums, :through => :album_tours, :primary_key => 'tours_id', :foreign_key => 'tour_id'

  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def tour_dates
    tour_dates = ''
    if  concert_bands.present?
      concert_bands.each do |f|
        tour_dates = "#{tour_dates.to_s} <tr><td>#{link_to f.concert_date, "/#{I18n.locale}/concerts/#{f.concert_id}"}</td><td>#{f.bootleg_name.gsub(/\\'/, '\'')}</td></tr>\n"
      end
    end
    tour_dates.html_safe
  end

  def band_name
    band_name = Array.new
    if bands.present?
      bands.each do |f|
        band_name.push f.band_name.to_s
      end
    end
    band_name
  end


  def official_releases_info
    official_releases_info = ''
    if albums.present?
      albums.order('release_year').each do |f|
        official_releases_info = "#{official_releases_info} <tr><td>#{f.album_name}</td><td>#{f.album_amazon_ad}</td></tr>"
      end
    end
    official_releases_info.html_safe
  end




end