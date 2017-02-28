class CommentsController < ApplicationController
  before_action :set_comment, :only => [:show, :edit, :update, :destroy]
  layout 'testui'

  def index

  end

  def show

  end

  def edit
    if cookies[:user_id].present?
      puts @comment.inspect.red
      bootleg_id = @comment.bootleg_id
      @roio = Roio.find(bootleg_id)
    else
      note = "#{t('you_must_be_logged_in_to_add_a')} #{t('comment').titleize}"
      begin
        redirect_to URI(request.referer).path + "?note=" + note
      rescue
        redirect_to :controller => 'index', :action => 'index' and return
      end
    end
  end

  def new
    if cookies[:user_id].present?
      bootleg_id = params[:roio_id]
      @roio = Roio.find(bootleg_id)
      @comment = Comment.new
    else
      note = "#{t('you_must_be_logged_in_to_add_a')} #{t('comment').titleize}"
      begin
        redirect_to URI(request.referer).path + "?note=" + note
      rescue
        redirect_to :controller => 'index', :action => 'index' and return
      end
    end
  end

  def create
    @comment = Comment.new(comment_params)
    puts @comment.inspect.magenta
    @comment.orig_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @comment.nick = session[:user_name]
    @comment.email = session[:email]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :controller => 'concerts', :action => 'show', :id => @comment.concert_id, :notice => 'Comment was successfully created.' }
        format.json { render :show, :status => :created, :location => @comment }
      else
        format.html { render :new }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end

  end

  def update
    puts @comment.inspect.magenta
    @comment.orig_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @comment.nick = session[:user_name]
    @comment.email = session[:email]

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to :controller => 'concerts', :action => 'show', :id => @comment.concert_id, :notice => 'Comment was successfully created.' }
        format.json { render :show, :status => :created, :location => @comment }
      else
        format.html { render :new }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:bootleg_id, :concert_id, :review, :email, :nick,:review_time, :orig_date)
    end

end
