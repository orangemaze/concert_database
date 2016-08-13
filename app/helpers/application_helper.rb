module ApplicationHelper

  def fix_bad_dates_in_db(bad_date)
    # good_date = bad_date
    case bad_date.to_s
      when /(\d{4})-(\d{2})-(\d{2})/
        good_date = bad_date.to_s
      when /xxxx-xx-xx/
        good_date = (bad_date.to_s.gsub('xxxx-xx-xx', '9999-01-01')).to_s
      when /xxxx - xxxx/
        good_date = (bad_date.to_s.gsub('xxxx - xxxx', '9999-01-01')).to_s
      when /(\d{3})x-xx-xx/
        good_date = (bad_date.to_s.gsub('x-xx-xx', '0-01-01')).to_s
      when /(\d{4})-xx-xx/
        good_date = (bad_date.to_s.gsub('-xx-xx', '-01-01')).to_s
      when /(\d{4})-(\d{2})/
        good_date = (bad_date.to_s + '-01').to_s
      when /(\d{4})/
        good_date = (bad_date.to_s + '-01-01').to_s
      when /(\d{4})-00-00/
        good_date = (bad_date.to_s.gsub('-00-00', '-01-01')).to_s
      else
        good_date = '<span style="color:red;font-size:20pt;">' +  bad_date.to_s + '</span>'
    end
  end

  def get_image_location(concert_date, bootleg_id, bootleg_name, image_size)
    image_year = concert_date[0..3]
    case image_size
      when /small/
        image_height = '30px'
        image_width = '30px'
      when /normal/
        image_height = '300px'
        image_width = '300px'
      else
        image_height = '30px'
        image_width = '30px'
    end
    image_locaton = "<img src='http://www.concerts-db.com/art/#{image_year}/#{bootleg_id}/#{concert_date}-cov.jpg' height='#{image_height}' width='#{image_width}' alt='#{bootleg_name.gsub(/\\'/, '\'')}' title='#{bootleg_name.gsub(/\\'/, '\'')}'>".html_safe

  end

  def turn_to_ratings_stars(rating)
    case rating.to_i
      when 0..1
        'no stars'
      when 2..3
        '<i class="fa fa-star-half" aria-hidden="true"></i>'
      when 4..5
        '<i class="fa fa-star" aria-hidden="true"></i>'
      when 6..7
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-half" aria-hidden="true"></i>'
      when 8..9
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i>'
      when 10..11
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-half" aria-hidden="true"></i>'
      when 12..13
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i>'
      when 14..15
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-half" aria-hidden="true"></i>'
      when 16
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i>'
    end
  end
end
