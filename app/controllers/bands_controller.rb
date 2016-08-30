class BandsController < ApplicationController
  layout 'testui'

  puts '=== band controller ==='.red

  def index
    @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Band.find(params[:id])

    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@data_result.band_name).present?
        @is_moderator = 'y'
      else
        @is_moderator = 'n'
      end
    else
      @is_moderator = 'n'
    end
  end

  def edit
    @band = Band.find(params[:id])
    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@band.band_name).present?
        @is_moderator = 'y'
      else
        redirect_to("/index")
      end
    else
      redirect_to("/index")
    end
  end

  def create
    @band = Band.new(band_params)

    respond_to do |format|
      if @band.save
        format.html { redirect_to @band, :notice => 'Band was successfully created.' }
        format.json { render :show, :status => :created, :location => @band }
      else
        format.html { render :new }
        format.json { render :json => @band.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @band = Band.find(params[:id])
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to @band, :notice => 'Band was successfully updated.' }
        format.json { render :show, :status => :ok, :location => @band }
      else
        format.html { render :edit }
        format.json { render :json => @band.errors, :status => :unprocessable_entity }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def band_params
      params.require(:band).permit(:band_name, :bio)
    end


end

