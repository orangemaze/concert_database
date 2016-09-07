module AdminHelper

  def is_band_moderator(band_id)
    is_moderator = ''
    puts '=== is moderator ==='.red

    # puts session[:band_moderator].inspect.blue
    if @moderator_band_names.present?
      if @moderator_band_names.key(band_id).present? || session[:admin] == 1
        is_moderator = 'y'
      else
        is_moderator = 'n'
      end
    else
      is_moderator = 'n'
    end
    is_moderator
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