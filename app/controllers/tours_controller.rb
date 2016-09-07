class ToursController < ApplicationController
  layout 'testui'
  def index
    puts 'Roios'.blue
    @data_result = Tour.all.limit(200) # commented for testing
  end

  def show
    @data_result = Tour.find(params[:id])
    puts "this is it".red
    puts @moderator_band_names.inspect.blue
    puts @data_result.band_name[0].green
    if @moderator_band_names.present?
      puts 'and here...'.red
      if @moderator_band_names.has_value?(@data_result.band_name[0]).present? or (session[:admin].to_i == 1)
        puts 'finally!!'.blue
        @is_moderator = 'y'
      else
        @is_moderator = 'n'
      end
    else
      @is_moderator = 'n'
    end
  end

  def edit
    @tour = Tour.find(params[:id])
    puts 'edit'.blue
    puts @tour.inspect.red
    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@tour.band_name[0]).present? or (session[:admin].to_i == 1)
        @is_moderator = 'y'
      else
        redirect_to("/index")
      end
    else
      redirect_to("/index")
    end
  end

  def create
    @tour = Tour.new(tour_params)

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, :notice => 'Tour was successfully created.' }
        format.json { render :show, :status => :created, :location => @tour }
      else
        format.html { render :new }
        format.json { render :json => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @tour = Tour.find(params[:id])
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to @tour, :notice => 'Band was successfully updated.' }
        format.json { render :show, :status => :ok, :location => @tour }
      else
        format.html { render :edit }
        format.json { render :json => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @band = Tour.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tour_params
    params.require(:tours).permit(:tour_name, :start_date, :end_date, :band_id, :total_shows)
  end


end