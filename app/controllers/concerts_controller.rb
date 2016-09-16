class ConcertsController < ApplicationController
  layout 'testui'

  before_filter :announce_controller

  def announce_controller
    puts '=== concert controller ==='.magenta
  end

  def index
    puts 'Concerts'.blue
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
    puts ' == show =='.green
    puts flash.inspect.to_s.magenta
    puts '-- flash above --'

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

    @concert.concert_bands << ConcertBand.first


    respond_to do |format|
      if @concert.save
        format.html { redirect_to @concert, :notice => 'Album was successfully created.' }
        format.json { render :show, :status => :created, :location => @concert }
      else
        format.html { render :new }
        format.json { render :json => @concert.errors, :status => :unprocessable_entity }
      end
    end
  end



  def roio_details
    @data_result = Roio.find(params[:id])
    render :layout => false
  end

  private
  def set_index
    @data_result = Concert.find(params[:id])
  end

  def concert_params
    params.require(:concert).permit(:concert_date, :time_of_show, :notes)
  end


end