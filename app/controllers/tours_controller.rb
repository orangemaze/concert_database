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
        redirect_to(index_index_path)
      end
    else
      redirect_to(index_index_path)
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

  def add_remove_concert_to_tour
    @tour = Tour.find(params[:id])

    tour_id = params[:id]
    band_id = params[:band_id]
    user_action = params[:user_action]
    choice = params[:choice].split(',')

    choice.each do |v|
      if user_action == 'add'
        sql = "replace into concert_band (concert_id, tours_id, band_id) values (#{v}, #{tour_id}, #{band_id})"
      else
        sql = "delete from concert_band where concert_id = #{v} and tours_id = #{tour_id} and band_id = #{band_id}"
      end
      ActiveRecord::Base.connection.execute(sql)
    end
    render :layout => false
  end

  def push_members_to_all_shows_in_tour
    @tour = Tour.find(params[:id])
    #TODO: need to add to the database
    redirect_to edit_tour_path(params[:id])
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