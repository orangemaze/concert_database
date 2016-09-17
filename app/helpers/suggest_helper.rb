module SuggestHelper

  def search_suggest(input, search_action, addl_action)
     puts addl_action.to_s.magenta
     if addl_action != 'suggest'
       search_action = addl_action
     end

     puts search_action.to_s.blue

    if search_action == 'Venues' or search_action == 'venue'
      puts '--venues--'.red
      @suggest_result = Band.select('venue.venue_id, venue_names.venue_name, city.city_name, states.state_name, states.state_abbr, flags.country, flags.iso_codes').from('venue_names').joins('left join venue on venue_names.venue_id = venue.venue_id').joins('left join city on venue.venue_city_id = city.city_id').joins('left join states on venue.venue_state_id = states.state_id').joins('left join flags on venue.venue_country_id = flags.flags_id').where('venue_names.venue_name like ?', "%#{input}%").group('venue_names.venue_name').order('venue_names.venue_name').limit(75)

    elsif search_action == 'Concerts'
      puts '--concerts--'.red
      @suggest_result = Band.select('concerts.concert_id, concerts.concert_date, concerts.ratingTotal, concerts.ratingCount, band.band_name, venue_names.venue_name').from('concerts').joins('left join concert_band on concerts.concert_id = concert_band.concert_id').joins('left join band on concert_band.band_id = band.band_id').joins('left join concert_venue on concerts.concert_id = concert_venue.concert_id').joins('left join venue_names on concert_venue.venue_id = venue_names.venue_id').where('concerts.concert_date like ?', "%#{input}%").group('concerts.concert_id, band.band_id, venue_names.venue_id').order('concerts.concert_date').limit(75)

    elsif search_action == 'Tours'
      puts '--Tours--'.red
      @search_result = Band.select('tour_id, tour_name, start_date, end_date, band_id').from('tours').where('band_id = ?',  "%#{input}%")

    elsif search_action == 'tours'
      puts '--tours--'.red
      @search_result = Tour.select('tours_id, tour_name, start_date, end_date, band_id').from('tours').where('tour_name like ?',  "%#{input}%")

    else
      puts '--else--'.red
      @suggest_result = Band.select('band_name.band_id, band_name.band_name').from('band_name').where('band_name.band_name like ?', "%#{input}%").group('band_name.band_name').order('band_name.band_name').limit(75)

    end # if search_action
  end # def venueSuggest

end