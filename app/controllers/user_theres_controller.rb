class UserTheresController < ApplicationController
  before_action :set_user_there, :only => [:show, :edit, :update, :destroy]
  layout 'testui'

  def index
    @user_there = UserThere.all
  end

  def edit

  end

  def show

  end

  def new
    concert_id = params[:concert_id]
    @concert = Concert.find(concert_id)
    @user_there = UserThere.new
    puts @user_there.inspect
  end

  def create
    @user_there = UserThere.new(user_there_params)
    @user_there.user_id = session[:users_id] 
    @user_there.date_changed = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @user_there.date_added = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @user_there.save
        format.html { redirect_to @user_there, :notice => 'successfully created.' }
        format.json { render :show, :status => :created, :location => @user_there }
      else
        format.html { render :new }
        format.json { render :json => @user_there.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @user_there.update(user_there_params)
        format.html { redirect_to @user_there, :notice => 'successfully updated.' }
        format.json { render :show, :status => :ok, :location => @user_there }
      else
        format.html { render :edit }
        format.json { render :json => @user_there.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @user_there.destroy
    respond_to do |format|
      format.html { redirect_to user_there_url, :notice => 'successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_there
      @user_there = UserThere.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_there_params
      params.require(:user_there).permit(:user_id, :concert_id, :user_comment,:user_seat_section,:user_seat_row,:user_seat)
    end

end
