class BandAlbumsController < ApplicationController
  before_action :set_band_albums, :only => [:show, :edit, :update, :destroy]
  layout 'testui'

  puts '=== band albums controller ==='.red

  def index
    @band_albums = BandAlbum.all
  end

  def edit
  end

  def new
    @band_album = BandAlbum.new
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_band_albums
      @band_album = BandAlbum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def band_album_tour_params
      params.require(:band_album).permit(:album_id, :band_id)
    end

end
