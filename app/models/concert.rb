class Concert < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  self.table_name = 'concerts'
  has_many :roios, :primary_key => 'concert_id'
  belongs_to :concert_venue, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :band_members, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :reviews, :through => :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :concert_ratings, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :images, :through => :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'

  def this_test
    this_test = 'this test'
  end

  def bootleg_name
    if roios.present?
      data_holder = ''
      roios.each do |f|
        puts '=== here ==='
        roio_image = ''
        bootleg_id = f.bootleg_id
        bootleg_name = f.bootleg_name.gsub(/\\'/, '\'')
        roio_type = ApplicationController.helpers.turn_roio_type_into_icon(f.roio_type, 'normal')
        roio_format = f.roio_format
        band_name = f.band_name
        roio_image = ApplicationController.helpers.get_image_location(concert_date, bootleg_id, bootleg_name, 'small', f.roio_image_count)
        data_holder = "#{data_holder.to_s} <a href='#' id='#{bootleg_id.to_s}' class='roio-details list-group-item'> #{roio_image}
        #{roio_type.to_s} #{band_name.to_s} #{ApplicationController.helpers.turn_to_ratings_stars(f.roio_avg_rating)} &middot; #{bootleg_name.to_s}
            <span class='pull-right text-muted small'><em>#{roio_format.to_s}</em></span>
        </a>"

      end
      data_holder.html_safe
    end
  end


  def concert_avg_rating
    puts concert_ratings.inspect.green
    begin
      concert_avg_rating = ''
      if  concert_ratings.present?
        concert_ratings.each do |f|
          concert_avg_rating = concert_avg_rating.to_f + f.rating.to_f
        end
      end
      concert_avg_rating = concert_ratings.present? ? (concert_avg_rating.to_f / concert_ratings.count).to_i : 'no ratings'
    rescue
      concert_avg_rating = ''
    end
  end


  def venue_id
    venue_id = concert_venue.present? ? concert_venue.venue_id : concert_venue.inspect
  end

  def venue_address
    venue_address = concert_venue.present? ? concert_venue.venue_address : concert_venue.inspect
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
    band_name = Hash.new
    if concert_bands.present?
      concert_bands.order('band_position').each do |k ,v|
        k.band_name.each do |x, y|
          puts '== band name =='
          puts x.to_s.blue
          puts y.inspect.to_s.red
          band_name[x] = y
        end
      end
    end
    band_name
  end

  def tour_name_plain
    tour_name = Hash.new
    if concert_bands.present?
      concert_bands.each do |k ,v|
        k.tour_name.each do |x, y|
          puts '== tour name =='
          puts x.to_s.blue
          puts y.inspect.to_s.red
          tour_name[x] = y
        end
      end
    end
    tour_name
  end

  def band_member_names
    band_member_names = Hash.new
    if band_members.present?
      band_members.each do |k ,v|
        k.band_member_names.each do |x, y|
          puts '== member name =='
          puts x.to_s.blue
          puts y.inspect.to_s.red
          band_member_names[x] = y
        end
      end
    end
    band_member_names
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