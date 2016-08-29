module AdminHelper

  def is_band_moderator(band_id)
    is_moderator = ''
    puts '=== is moderator ==='.red

    # puts session[:band_moderator].inspect.blue
    if @moderator_band_names.present?
      if @moderator_band_names.key(band_id).present?
        is_moderator = 'y'
      else
        is_moderator = 'n'
      end
    else
      is_moderator = 'n'
    end
    is_moderator
  end

end