class AlbumToursController < ApplicationController
  before_action :set_album_tour, only: [:show, :edit, :update, :destroy]

  # GET /album_tours
  # GET /album_tours.json
  def index
    @album_tours = AlbumTour.all
  end

  # GET /album_tours/1
  # GET /album_tours/1.json
  def show
  end

  # GET /album_tours/new
  def new
    @album_tour = AlbumTour.new
  end

  # GET /album_tours/1/edit
  def edit
  end

  # POST /album_tours
  # POST /album_tours.json
  def create
    @album_tour = AlbumTour.new(album_tour_params)

    respond_to do |format|
      if @album_tour.save
        format.html { redirect_to @album_tour, notice: 'Album tour was successfully created.' }
        format.json { render :show, status: :created, location: @album_tour }
      else
        format.html { render :new }
        format.json { render json: @album_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /album_tours/1
  # PATCH/PUT /album_tours/1.json
  def update
    respond_to do |format|
      if @album_tour.update(album_tour_params)
        format.html { redirect_to @album_tour, notice: 'Album tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @album_tour }
      else
        format.html { render :edit }
        format.json { render json: @album_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /album_tours/1
  # DELETE /album_tours/1.json
  def destroy
    @album_tour.destroy
    respond_to do |format|
      format.html { redirect_to album_tours_url, notice: 'Album tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album_tour
      @album_tour = AlbumTour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_tour_params
      params.require(:album_tour).permit(:album_id, :tour_id)
    end
end
