class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception
  # layout 'application'

  before_filter :authenticate_user, :am_i_moderator

  puts '===  application controller ==='.blue

  def authenticate_user
    if cookies[:user_id].present?
      # check if user_id from matches in db, then get admim number
      @user_info = UserInfo.new(cookies[:user_id])
      if @user_info.user_name.nil?

      else
        session[:user_id] = @user_info.user_id
        session[:admin] = @user_info.admin
        session[:user_name] = @user_info.user_name
        session[:email] = @user_info.email
        session[:f_name] = @user_info.f_name
        session[:l_name] = @user_info.l_name
        session[:admin] = @user_info.admin
        session[:trader] = @user_info.trader
        session[:avatar_96] = @user_info.avatar_96
        session[:avatar_24] = @user_info.avatar_24
        session[:language_id] = @user_info.language_id
        Band.current_user = @user_info.user_id
      end

      puts 'user cookie and session is now present'.red
    end

  end

  def am_i_moderator
    if cookies[:user_id].present?
      moderator_list = Moderator.where('md5(user_id) = ?', cookies[:user_id])
      @moderator_band_names = Hash.new
      moderator_list.each do |f|
        @moderator_band_names[f.band_id] = f.band_name.to_s
      end if moderator_list.present?
    end
    @moderator_band_names
  end



end
