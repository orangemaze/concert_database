module ImageHelper

  def get_image_location(concert_date, bootleg_id, bootleg_name, image_size, image_count, bootleg_image)
    case image_size
      when /small/
        image_height = '30'
        image_width = '30'
      when /normal/
        image_height = '300'
        image_width = '300'
      else
        image_height = '30'
        image_width = '30'
    end

    case bootleg_image.split(".")[1]
      when /jpg/
        image_format = 'jpg'
      when /png/
        image_format = 'png'
      else
        image_format = 'jpg'
    end

    if bootleg_image == 'no_art.jpg'
      url = "http://www.concerts-db.com/images/no_art.jpg"
    else
      url = "http://www.concerts-db.com/art/#{concert_date[0..3]}/#{bootleg_id}/#{concert_date}-cov.#{image_format}"
    end

    "<img src='#{url}' height='#{image_height}' width='#{image_width}' alt='#{bootleg_name.gsub(/\\'/, '\'')}' title='#{bootleg_name.gsub(/\\'/, '\'')}'>".html_safe

  end

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

  def get_user_avatar(user_name, user_id, a_24, a_96, size)
    user_dir = user_name[0..2]
    case size
      when 'small'
        "/user_images/#{user_dir}/#{user_id}/#{a_24}"
      when 'large'
        "/user_images/#{user_dir}/#{user_id}/#{a_96}"
      else
        "/user_images/#{user_dir}/#{user_id}/#{a_24}"
    end
  end

end