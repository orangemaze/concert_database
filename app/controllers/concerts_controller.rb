class ConcertsController < ApplicationController
  layout 'testui'

  before_filter :announce_controller

  def announce_controller
    puts '=== concert controller ==='.magenta
  end

  def index
    #puts 'Concerts'.blue
    # @data_result = Concert.all.limit(20) # commented for testing
  end

  def new
    if session[:admin].present?
      if session[:admin].to_i < 5
        @concert = Concert.new
      else
        redirect_to URI(request.referer).path
      end
    else
      redirect_to URI(request.referer).path
    end
  end

  def edit
    @concert = Concert.find(params[:id])
    puts 'edit'.blue
    puts @concert.inspect.red
    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@concert.band_name[0]).present? or (session[:admin].to_i == 1)
        @is_moderator = 'y'
      else
        redirect_to URI(request.referer).path
      end
    else
      redirect_to URI(request.referer).path
    end
  end

  def show
    @data_result = Concert.find(params[:id])
    # puts ' == show =='.green
    # puts flash.inspect.to_s.magenta
    # puts '-- flash above --'

    @note = params[:note].present? ? params[:note] : ''


    @data_result.inspect.red
    if @moderator_band_names.present?
      if (@moderator_band_names.has_value?(@data_result.band_name[0]).present?) or (session[:admin].to_i == 1)
        @is_moderator = 'y'
      else
        @is_moderator = 'n'
      end
    else
      @is_moderator = 'n'
    end
  end

  def update
    @concert = Concert.find(params[:id])
    respond_to do |format|
      if @concert.update(concert_params)
        format.html { redirect_to @concert }
        format.json { render :show, :status => :ok, :location => @concert }
      else
        format.html { render :edit }
        format.json { render :json => @concert.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create
    @concert = Concert.new(concert_params)
    @concert.save
    params[:concert][:concert_id] = @concert.concert_id
    puts @concert.inspect.green
    concert_date = params[:concert][:concert_date]
    venue_name = params[:concert][:venue_name]
    city_name = params[:concert][:city_name]
    state_name = params[:concert][:state_name]
    country = params[:concert][:country]
    time_of_show = params[:concert][:time_of_show]
    no_known_recording = params[:concert][:no_known_recording]
    notes = params[:concert][:notes]
    band_name = params[:concert][:band_name]
    params[:concert][:tour_name] = params[:concert][:tour_name_plain]

    band_id = params[:concert][:band_id]
    tours_id = params[:concert][:tours_id]
    venue_id = params[:concert][:venue_id]
    city_id = params[:concert][:city_id]
    state_id = params[:concert][:state_id]
    flags_id = params[:concert][:flags_id]


    if band_id.present?
      # nothing yet
    else
      @concert = Band.new(band_params)
      @concert.save
      puts 'no band_id, band added'.blue
      puts @concert.inspect.green
    end

    if tours_id.present?
      # nothing yet
    else
      @concert = Tour.new(tour_params)
      @concert.save
      puts 'no tour_id, tour added'.blue
      puts @concert.inspect.green
      params[:concert][:tours_id] = @concert.tours_id
    end

    puts @concert.inspect.magenta
    params[:concert][:band_position] = '10'
    @concert = ConcertBand.new(concert_band_params)
    @concert.save
    puts @concert.inspect.blue
    puts 'then concert_band'.blue
    puts @concert.inspect.green


    if venue_id.present?
      @concert = ConcertVenue.new(concert_venue_params)
      @concert.save 
      puts 'venue_id is present, added to concert_venue'.red
    else
      if city_id.blank?
        @concert = City.new(city_params)
        @concert.save   
        puts 'city_id is blank'.red
      end

      if state_id.blank?
        @concert = State.new(state_params)
        @concert.save
        puts 'state_id is blank'.red
      end

      if flags_id.blank?
        @concert = County.new(country_params)
        @concert.save
        puts 'flags_id is blank'.red
      end
      #@concert.venues << ConcertVenue.new(venue_params)
      #@concert.concert_venues << ConcertVenue.new(concert_venue_params)
      #@concert.venue_names << VenueName.new(venue_name_params)
    end

    redirect_to concert_path(params[:concert][:concert_id]), :notice => 'concert was created'
  end



  def roio_details
    @data_result = Roio.find(params[:id])
    render :layout => false
  end

  def roio_add_comment
    @roio_id = params[:id]
    render :layout => false
  end

  private
  def set_index
    @data_result = Concert.find(params[:id])
  end

  def concert_params
    params.require(:concert).permit(:concert_date, :time_of_show, :notes)
  end

  def band_params
    params.require(:concert).permit(:band_id, :band_name)
  end

  def tour_params
    params.require(:concert).permit(:band_id, :tour_name)
  end

  def concert_band_params
    params.require(:concert).permit(:concert_id, :band_id, :tours_id, :band_position)
  end

  def city_params
    params.require(:concert).permit(:city_name)
  end

  def venue_params
    params.require(:concert).permit(:venue_name, :venue_city_id, :venue_state_d, :venue_country_id)
  end

  def venue_name_params
    params.require(:concert).permit(:venue_name, :venue_id)
  end


  def concert_venue_params
    params.require(:concert).permit(:concert_id, :venue_id)
  end

end
