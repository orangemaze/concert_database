class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  protect_from_forgery :with => :exception
  # layout 'application'

  before_filter :authenticate_user, :am_i_moderator, :set_current_locale #, :current_user

  puts '=== application controller ==='.blue

  def authenticate_user
    if cookies[:user_id].present?
      # check if user_id from matches in db, then get admim number
      @user_info = UserInfo.new(cookies[:user_id])
      if @user_info.user_name.nil?

      else
        session[:users_id] = @user_info.user_id
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
        puts "#{session[:users_id]} #{session[:f_name]} #{session[:l_name]} session is now present".red
      end

      puts "#{cookies[:user_name]} cookie is now present".red
    end

  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
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

  private
  def set_current_locale
    I18n.locale = params[:locale]
  end


  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

end
