class Concert < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  self.table_name = 'concerts'
  has_many :roios, :primary_key => 'concert_id'
  belongs_to :concert_venue, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :band_members, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :reviews, :through => :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'

  def this_test
    this_test = 'this test'
  end

  def bootleg_name
    if roios.present?
      data_holder = ''
      roios.each do |f|
        bootleg_id = f.bootleg_id
        bootleg_name = f.bootleg_name.gsub(/\\'/, '\'')
        roio_type = ApplicationController.helpers.turn_roio_type_into_icon(f.roio_type, 'normal')
        roio_format = f.roio_format
        band_name = f.band_name
        data_holder = "#{data_holder.to_s} <a href='#' id='#{bootleg_id.to_s}' class='roio-details list-group-item'>#{ApplicationController.helpers.get_image_location(concert_date, bootleg_id, bootleg_name, 'small')}
        #{roio_type.to_s} #{band_name.to_s} #{ApplicationController.helpers.turn_to_ratings_stars(f.roio_avg_rating)} &middot; #{bootleg_name.to_s}
            <span class='pull-right text-muted small'><em>#{roio_format.to_s}</em></span>
        </a>"

      end
      data_holder.html_safe
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
        band_id = band_id + f.band_id.to_s
      end
    end
    band_id.html_safe
  end


  def band_name
    band_name = ''
    if concert_bands.present?
      concert_bands.order('band_position').each do |f|
        band_name = band_name + f.band_details.to_s
      end
    end
    band_name.html_safe
  end

  def band_name_plain
    band_name = ''
    if concert_bands.present?
      concert_bands.order('band_position').each do |f|
        band_name = band_name + f.band_name.to_s
      end
    end
    band_name.html_safe
  end

  def bootleg_name_plain
    bootleg_name_plain = ''
    if roios.present?
      roios.each do |f|
        bootleg_name_plain = bootleg_name_plain + f.bootleg_name.to_s
      end
    end
    bootleg_name_plain.html_safe

  end



  def tour_name
    tour_name = ''
    if concert_bands.present?
      concert_bands.each do |f|
        tour_name = tour_name + f.tour_name.to_s
      end
    end
    tour_name.html_safe
  end

  def get_ui_comments
    get_ui_comments = ''

    if reviews.present?
      reviews.order('orig_date').reverse.each do |f|
        get_ui_comments = get_ui_comments + "
        <li class='" + cycle('', 'timeline-inverted') +"'>
          <div class='timeline-badge'><i class='fa fa-comments-o'></i>
          </div>
          <div class='timeline-panel'>
            <div class='timeline-heading'>
              <h4 class='timeline-title'>#{f.bootleg_name} <small>#{f.nick}</small></h4>
              <p><small class='text-muted'><i class='fa fa-clock-o'></i> #{f.review_time}</small>
              </p>
            </div>
            <div class='timeline-body'>
              <p>#{f.review.gsub(/&lt;/, '<').gsub(/&gt;/, '>')}</p>
            </div>
          </div>
        </li>"
      end
    end
    get_ui_comments.html_safe
  end

end