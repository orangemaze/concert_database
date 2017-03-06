module RoioSetListHelper

  def find_songs_options(set)
    # work through first set
    song_select_options = Hash.new
    set_list_array = set.split( /\r?\n/ )
    #puts set_list_array.inspect.magenta
    set_list_array.each do |v|
      song_options = Hash.new
      # puts v.to_s.red
      songs = Song.where("song_name like ?", "%#{v}%")
      songs.each do |y|
        # puts y.song_name.green
        if  (v.to_s.similar(y.song_name)) == 100.0
          selected = 'selected'
        else
          selected = ''
        end  
        song_options[y.songs_id] = "<option value='#{y.songs_id}' #{selected}>#{y.song_name}</option>"
      end
      song_select_options[v] = song_options
    end # each
    return song_select_options
  end

  def save_songs_to_db(set, set_letter)
    count_this = 1
    set.each do |v|
      puts v.inspect.magenta
      params[:roio_set_list][:songs_id] = v.to_s
      params[:roio_set_list][:bootleg_id] = params[:roio_set_list][:roio_id]
      params[:roio_set_list][:orig_bootleg_id] = params[:roio_set_list][:roio_id]
      params[:roio_set_list][:set_position] = "#{set_letter}#{count_this.to_s.rjust(2, '0')}"
      params[:roio_set_list][:orig_concert_id] = params[:roio_set_list][:concert_id]
      params[:roio_set_list][:notes] = ''
      count_this = count_this + 1
      #puts params.inspect 

      @roio_set_list = RoioSetList.new(roio_set_list_params)
      puts @roio_set_list.inspect
      @roio_set_list.save
    end
  end

end
