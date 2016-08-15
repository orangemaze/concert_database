module ImageHelper

  def get_main_image
    begin
      main_image = MainImage.all # commented for testing
      random_number = rand(1..main_image.count)
      image_name = main_image[random_number].image_name
      image_url = "//www.pf-db.com/images/main/#{image_name}"
    rescue
      image_url = "//www.pf-db.com/images/main/IMAGE_00014.jpg"
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

  def get_roio_image_count_icon(image_count)
    if image_count.to_i == 0
      "No Images, would you like to add some?"
    elsif image_count.to_i == 1
      "<i class='fa fa-film' aria-hidden='true'></i>"
    elsif image_count.to_i > 1
      "<i class='fa fa-film fa-lg' aria-hidden='true'></i> <span class='badge'>#{image_count}</span>"
    else
      image_count.to_s
    end
  end


end