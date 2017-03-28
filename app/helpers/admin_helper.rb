module AdminHelper

  def is_band_moderator(band_id)
    is_moderator = 'n'
    puts '=== is moderator ==='.red
    if cookies[:user_id].present?
      if @moderator_band_names.present?
        if (@moderator_band_names.key(band_id).present?) or (session[:admin].to_i == 1)
          is_moderator = 'y'
        else
          is_moderator = 'n'
        end
      else
        is_moderator = 'n'
      end
    else
      is_moderator = 'n'
    end
    puts is_moderator.blue
    is_moderator
  end

  def is_logged_in
    cookies[:user_id].present? ? true : false
  end


  def admin_message(admin_level)
    if admin_level.present?
      case admin_level
        when '1'
          'With great power, comes great responsibility, you have unlimited power'
        when '2'
          '2'
        when '3'
          '3'
        when '4'
          '4'
        when '5'
          '5'
        else
          ''
      end
    else
      # nothing
    end
  end

  def browser_name
    user_agent = request.env['HTTP_USER_AGENT'].downcase
    case user_agent
      when /chrome/i
        'Chrome'
      when /gecko/i
        'Mozilla'
      when /safari/i
        'Safari'
      when /trident/i
        'Internet Explorer'
      when /googlebot/i
        'googlebot'
      else
        'Unknown'
    end
  end

  def os_name
    user_agent = request.env['HTTP_USER_AGENT'].downcase
    case user_agent
      when /windows/i
        'Windows'
      when /android/i
        'Android'
      when /ubuntu/i
        'Ubuntu'
      when /linux/i
        'Linux'
      when /mac/i
        'Mac'
      when /googlebot/i
        'googlebot'
      else
        'Unknown'
    end

  end

end