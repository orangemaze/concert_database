class UsersController < ApplicationController
  layout 'testui'
  def index
    redirect_to root_path
  end

  def show
    if params[:id] == cookies[:user_id]
      puts params[:id].to_s.red


      @data_result = User.where('md5(user_id) = ?', params[:id])

    else
      redirect_to root_path
    end
  end

  def edit
    if params[:id] == cookies[:user_id]
      puts params[:id].to_s.red
      @data_result = User.where('md5(user_id) = ?', params[:id]).limit(1)
    else
      redirect_to root_path
    end
  end

  def update
      puts params[:id].to_s.red
      @data_result = User.where('md5(user_id) = ?', params[:id]).limit(1)
      respond_to do |format|
        if @data_result[0].update(user_params)
          format.html { redirect_to :controller => 'users', :action => 'show', :id => cookies[:user_id], :notice => 'Band was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
  end


  def new

  end

  def change_language
    puts params[:id].to_s.red
    @data_result = User.where('md5(user_id) = ?', params[:id]).limit(1)
    respond_to do |format|
      if @data_result[0].update(user_params)
        format.html {
          # redirect_to :controller => 'users', :action => 'show', :id => cookies[:user_id], :notice => 'Band was successfully updated.'
          redirect_to(URI(request.referer).path, :notice => 'Band was successfully updated.')
        }
      else
        format.html { render :edit }
      end
    end

  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @data_result = User.where('md5(user_id) = ?', params[:id]).limit(1)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:data_result).permit(:user_name, :f_name, :l_name, :email, :url, :quote, :other, :language_id)
  end


end