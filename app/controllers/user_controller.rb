class UserController < ApplicationController
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

  def new

  end

end