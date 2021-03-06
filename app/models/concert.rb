class Concert < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  self.table_name = 'concerts'
  has_many :roios, :primary_key => 'concert_id'
  has_many :concert_venues, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :band_members, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :reviews, :through => :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :concert_ratings, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :images, :through => :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :bands, :through => :concert_bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :tours, :through => :concert_bands, :primary_key => 'tours_id', :foreign_key => 'tours_id'
  has_many :user_there, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :venues, :through => :concert_venues, :primary_key => 'venue_id', :foreign_key => 'venue_id'

  def this_test
    this_test = 'this test'
  end

  def the_venue_name(reload=false)
    #@the_venue_name = nil if reload
    @the_venue_name = VenueName.where('venue_id = ?', concert_venues[0].venue_id)
    #concert_venues[0].venue_id
  end


  def bootleg_name
    if roios.present?
      data_holder = ''
      roios.each do |f|
        # puts '=== here ==='
        roio_image = ''
        bootleg_id = f.bootleg_id
        bootleg_name = f.bootleg_name.gsub(/\\'/, '\'') rescue ''
        roio_type = ApplicationController.helpers.turn_roio_type_into_icon(f.roio_type, 'normal')
        roio_format = f.roio_format
        band_name = f.band_name
        bootleg_image = f.bootleg_image
        roio_image = ApplicationController.helpers.get_image_location(concert_date, bootleg_id, bootleg_name, 'small', f.roio_image_count, bootleg_image)
        data_holder = "#{data_holder.to_s} <li id='#{bootleg_id.to_s}' class='roio-details list-group-item'> #{roio_image}
        #{roio_type.to_s} #{band_name.to_s} #{ApplicationController.helpers.turn_to_ratings_stars(f.roio_avg_rating)} &middot; #{bootleg_name.to_s}
            <span class='pull-right text-muted small'><em>#{roio_format.to_s}</em></span>
        </li>"

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
    venue_id = ''
    if concert_venues.present?
      concert_venues.each do |f|
        venue_id = venue_id + f.venue_id.to_s
      end
    end
    venue_id.html_safe
  end

  def venue_address
    venue_address = ''
    if concert_venues.present?
      concert_venues.each do |f|
        venue_address = venue_address + f.venue_address.to_s
      end
    end
    venue_address.html_safe
  end

  def venue_name
    venue_name = ''
    if concert_venues.present?
      concert_venues.each do |f|
        venue_name = venue_name + f.venue_name.to_s
      end
    end
    venue_name.html_safe
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

  def city_name
    city_name = ''
    if concert_venues.present?
      concert_venues.each do |f|
        city_name = city_name + f.city_name.to_s
      end
    end
    city_name.html_safe
  end

  def city_id
    ''
  end

  def state_name
    state_name = ''
    if concert_venues.present?
      concert_venues.each do |f|
        state_name = state_name + f.state_name.to_s
      end
    end
    state_name.html_safe
  end

  def state_id
    ''
  end

  def country_name
    country_name = ''
    if concert_venues.present?
      concert_venues.each do |f|
        country_name = country_name + f.country_name.to_s
      end
    end
    country_name.html_safe
  end

  def flags_id
    ''
  end

  def tours_id
    ''
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
          # puts '== band name =='
          # puts x.to_s.blue
          # puts y.inspect.to_s.red
          band_name[x] = y
        end
      end
    end
    band_name
  end

  def prev_tour
    sql = "SELECT tours.tours_id FROM tours INNER JOIN `concert_band` ON `tours`.`tours_id` = `concert_band`.`tours_id` WHERE (concert_band.band_id = '#{tour_band_id.to_s}' and tours.start_date < '#{tour_start_date.to_s}') GROUP BY tours.tours_id  ORDER BY tours.start_date"
    prev_tour_s =  Tour.find_by_sql(sql).last
    prev_tour = prev_tour_s['tours_id'].to_s rescue nil
  end

  def next_tour
    sql = "SELECT tours.tours_id FROM tours INNER JOIN `concert_band` ON `tours`.`tours_id` = `concert_band`.`tours_id` WHERE (concert_band.band_id = '#{tour_band_id.to_s}' and tours.start_date > '#{tour_start_date.to_s}') GROUP BY tours.tours_id  ORDER BY tours.start_date"
    next_tour_s =  Tour.find_by_sql(sql).first
    next_tour = next_tour_s['tours_id'].to_s rescue nil
  end

  def prev_concert
    sql = "select concerts.concert_id, concerts.concert_date FROM concerts INNER JOIN `concert_band` ON `concerts`.`concert_id` = `concert_band`.`concert_id` WHERE (concert_band.band_id = '#{tour_band_id.to_s}' and concert_date < '#{concert_date.to_s}') GROUP BY concerts.concert_id  ORDER BY concerts.concert_date"
    puts sql.to_s.magenta
    prev_tour_s =  Concert.find_by_sql(sql).last
    prev_concert = prev_tour_s['concert_id'].to_s rescue nil
  end

  def next_concert
    sql = "select concerts.concert_id, concerts.concert_date FROM concerts INNER JOIN `concert_band` ON `concerts`.`concert_id` = `concert_band`.`concert_id` WHERE (concert_band.band_id = '#{tour_band_id.to_s}' and concert_date > '#{concert_date.to_s}') GROUP BY concerts.concert_id  ORDER BY concerts.concert_date"
    puts sql.to_s.magenta
    prev_tour_s =  Concert.find_by_sql(sql).first
    next_concert = prev_tour_s['concert_id'].to_s rescue nil
  end

  def band_member_names(band_id)
    band_member_names = Hash.new
    if band_members.present?
      band_members.where('band_id = ?', band_id).each do |k ,v|
        k.band_member_names.each do |x, y|
          # puts '== member name =='
          # puts x.to_s.blue
          # puts y.inspect.to_s.red
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

  def bootleg_name_plain_hash
    bootleg_name_plain_hash = Hash.new
    if roios.present?
      roios.each do |f|
        bootleg_name_plain_hash[f.bootleg_id.to_s] = f.bootleg_name.to_s
      end
    end
  end

  def tour_start_date
    tour_start_date = ''
    if concert_bands.present?
      concert_bands.each do |f|
        tour_start_date = tour_start_date + f.tour_start_date.to_s
      end
    end
    tour_start_date.html_safe
  end

  def tour_band_id
    tour_band_id = ''
    if concert_bands.present?
      concert_bands.each do |f|
        tour_band_id = tour_band_id + f.tour_band_id.to_s
      end
    end
    tour_band_id.html_safe
  end

  def were_you_there
    were_you_there = user_there

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


  def get_ui_comments(user_name)
    get_ui_comments = ''

    if reviews.present?
      reviews.order('orig_date').reverse.each do |f|
        edit_this_comment = ''
        if user_name.present?
          if user_name == f.nick
            edit_this_comment = "<a href='/#{I18n.locale}/comments/#{f.review_id}/edit'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>"
          end
        end


        get_ui_comments = get_ui_comments + "
        <li class='" + cycle('', 'timeline-inverted') +"'>
          <div class='timeline-badge'><i class='fa fa-comments-o'></i>
          </div>
          <div class='timeline-panel'>
            <div class='timeline-heading'>
              <h4 class='timeline-title'>#{f.bootleg_name} <small>#{f.nick} #{edit_this_comment}</small></h4>
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

  def no_known_recording_icon
    "<span class='fa-stack' title='No Known Recording' alt='No Known Recording'><i class='fa fa-microphone fa-stack-1x' title='No Known Recording' alt='No Known Recording'></i><i class='fa fa-ban fa-stack-2x text-danger' title='No Known Recording' alt='No Known Recording'></i></span>"
  end

end
