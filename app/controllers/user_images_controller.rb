class UserImagesController < ApplicationController
  before_action :set_album, :only => [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:upload_images]
  layout 'testui'
  # GET /albums
  # GET /albums.json
  def index
    @user_images = UserImage.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @user_images = UserImage.new
    render :layout => false
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @user_images = UserImage.new(album_params)

    respond_to do |format|
      if @user_images.save
        format.html { redirect_to @user_images, :notice => 'Album was successfully created.' }
        format.json { render :show, :status => :created, :location => @user_images }
      else
        format.html { render :new }
        format.json { render :json => @user_images.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @user_images.update(album_params)
        format.html { redirect_to @user_images, :notice => 'Album was successfully updated.' }
        format.json { render :show, :status => :ok, :location => @user_images }
      else
        format.html { render :edit }
        format.json { render :json => @user_images.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @user_images.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, :notice => 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_images
    puts params[:file]
    #puts params[:file][:UploadedFile]
    #puts params[:file][:tempfile]
    base_image_url = "#{::Rails.root}/public/user_images/"
    puts base_image_url.to_s.red
    render :layout => false  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @user_images = UserImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:album_name, :album_review, :album_amazon_ad,:release_year)
    end
end
