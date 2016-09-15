module AdminHelper

  def is_band_moderator(band_id)
    is_moderator = ''
    puts '=== is moderator ==='.red

    # puts session[:band_moderator].inspect.blue
    if session[:admin].to_i == 1
      is_moderator = 'y'
    elsif @moderator_band_names.present?
      puts @moderator_band_names.inspect
      puts session[:admin].to_s.magenta
      if @moderator_band_names.key(band_id).present? || session[:admin].to_i == 1
        is_moderator = 'y'
      else
        is_moderator = 'n'
      end
    else
      is_moderator = 'n'
    end

    puts is_moderator.blue
    is_moderator
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