module ApplicationHelper
  require 'json'
  require 'open-uri'


  def fix_bad_dates_in_db(bad_date)
    # good_date = bad_date
    case bad_date.to_s
      when /(\d{4})-(\d{2})-(\d{2})/
        bad_date.to_s
      when /xxxx-xx-xx/
        (bad_date.to_s.gsub('xxxx-xx-xx', '9999-01-01')).to_s
      when /xxxx - xxxx/
        (bad_date.to_s.gsub('xxxx - xxxx', '9999-01-01')).to_s
      when /(\d{3})x-xx-xx/
        (bad_date.to_s.gsub('x-xx-xx', '0-01-01')).to_s
      when /(\d{4})-xx-xx/
        (bad_date.to_s.gsub('-xx-xx', '-01-01')).to_s
      when /(\d{4})-(\d{2})/
        (bad_date.to_s + '-01').to_s
      when /(\d{4})/
        (bad_date.to_s + '-01-01').to_s
      when /(\d{4})-00-00/
        (bad_date.to_s.gsub('-00-00', '-01-01')).to_s
      when /0000-00-00/
        '9999-12-31'.to_s
      when //
        '9999-12-31'.to_s
      else
        '<span style="color:red;font-size:20pt;">' +  bad_date.to_s + '</span>'
    end
  end

  def get_referer_page
    begin
      URI(request.referer).path
    rescue
      '/index'
    end
  end

  def turn_roio_type_into_icon(roio_type, size)
    case size.to_s
      when 'large'
        font_size = 'fa-lg'
      else
        font_size = ''
    end

    case roio_type.to_s
      when 'roio'
        "<i class='fa fa-headphones #{font_size}' aria-hidden='true'></i>"
      when 'voio'
        "<i class='fa fa-television #{font_size}' aria-hidden='true'></i>"
      else
        "<i class='fa fa-headphones #{font_size}' aria-hidden='true'></i>"
    end
  end


  def turn_to_ratings_stars(rating)
    case rating.to_i
      when 0
        ''
      when 1
        '<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>'
      when 2..3
        '<i class="fa fa-star-half-o" aria-hidden="true"><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></i>'
      when 4..5
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>'
      when 6..7
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-half-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>'
      when 8..9
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>'
      when 10..11
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-half-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>'
      when 12..13
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>'
      when 14..15
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-half-o" aria-hidden="true"></i>'
      when 16
        '<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i>'
      else
        ''
    end
  end

end
