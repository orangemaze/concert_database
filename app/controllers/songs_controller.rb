class SongsController < ApplicationController
  before_action :set_song, :only => [:show, :edit, :update, :destroy]
  layout 'testui'

  def index

  end

  def show

  end

  def edit
    if cookies[:user_id].present?
      puts @song.inspect.red
      song_id = @song.song_id
      @song = Song.find(song_id)
    else
      note = "#{t('you_must_be_logged_in_to_add_a')} #{t('song').titleize}"
      begin
        redirect_to URI(request.referer).path + "?note=" + note
      rescue
        redirect_to :controller => 'index', :action => 'index' and return
      end
    end
  end

  def new
    if cookies[:user_id].present?
      bootleg_id = params[:song_id]
      @song = Song.find(song_id)
      @song = Song.new
    else
      note = "#{t('you_must_be_logged_in_to_add_a')} #{t('song').titleize}"
      begin
        redirect_to URI(request.referer).path + "?note=" + note
      rescue
        redirect_to :controller => 'index', :action => 'index' and return
      end
    end
  end

  def create
    @song = Song.new(comment_params)
    puts @song.inspect.magenta
    @song.orig_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @song.nick = session[:user_name]
    @song.email = session[:email]

    respond_to do |format|
      if @song.save
        format.html { redirect_to :controller => 'concerts', :action => 'show', :id => @song.concert_id, :notice => 'song was successfully created.' }
        format.json { render :show, :status => :created, :location => @song }
      else
        format.html { render :new }
        format.json { render :json => @song.errors, :status => :unprocessable_entity }
      end
    end

  end

  def update
    puts @song.inspect.magenta
    @song.orig_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @song.nick = session[:user_name]
    @song.email = session[:email]

    respond_to do |format|
      if @song.update(comment_params)
        format.html { redirect_to :controller => 'concerts', :action => 'show', :id => @song.concert_id, :notice => 'song was successfully created.' }
        format.json { render :show, :status => :created, :location => @song }
      else
        format.html { render :new }
        format.json { render :json => @song.errors, :status => :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:song).permit(:bootleg_id, :concert_id, :review, :email, :nick,:review_time, :orig_date)
    end

end
