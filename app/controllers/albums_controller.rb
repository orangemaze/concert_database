class AlbumsController < ApplicationController
  before_action :set_album, :only => [:show, :edit, :update, :destroy]
  layout 'testui'
  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, :notice => 'Album was successfully created.' }
        format.json { render :show, :status => :created, :location => @album }
      else
        format.html { render :new }
        format.json { render :json => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, :notice => 'Album was successfully updated.' }
        format.json { render :show, :status => :ok, :location => @album }
      else
        format.html { render :edit }
        format.json { render :json => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, :notice => 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def albums_to
    if cookies[:user_id].present?
      @band = Band.find(params[:id])
    else
      note = "#{t('you_must_be_logged_in_to_add_a')} #{t('comment').titleize}"
      begin
        redirect_to URI(request.referer).path + "?note=" + note
      rescue
        redirect_to :controller => 'index', :action => 'index' and return
      end
    end
  end

  def add_remove_album_to_band
    band_id = (params[:id])
    user_action = params[:user_action]
    choice = params[:choice].split(',')

    choice.each do |v|
      if user_action == 'add'
        sql = "replace into band_albums (band_id, album_id) values (#{band_id}, #{v})"
      else
        sql = "delete from band_albums where album_id = #{v} and band_id = #{band_id}"
      end
      ActiveRecord::Base.connection.execute(sql)
    end
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:album_name, :album_review, :album_amazon_ad, :release_year, :release_date, :flags_id, :matrix_code, :differences)
    end
end
