class UserController < ApplicationController
  layout 'testui'
  def index
    redirect_to root_path
  end

  def show
    if params[:id] == cookies[:user_id]


    else
      redirect_to root_path
    end
  end

  def new

  end

end