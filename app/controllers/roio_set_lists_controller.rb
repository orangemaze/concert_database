class RoioSetListsController < ApplicationController
  before_action :set_comment, :only => [:show, :edit, :update, :destroy]
  layout 'testui'
  include RoioSetListHelper
  require 'similar_text'

  def new
    if cookies[:user_id].present?
      puts '--   roio set lists : new'.magenta
      bootleg_id = params[:roio_id]
      @roio = Roio.find(bootleg_id)
      @roio_set_list = RoioSetList.new

      if params[:submit] == 'Submit'
        @select_options = find_songs_options(params[:set_1])
        #puts song_select_options.inspect.red
      elsif params[:submit] == 'Confirm'
        puts 'confirm'
        puts params.inspect.green
        #1
        save_songs_to_db(params[:songs_1], 'a')     
        #2
        save_songs_to_db(params[:songs_2], 'b') 
        #e        
        save_songs_to_db(params[:songs_e], 'e') 

        redirect_to :controller => 'concerts', :action => 'show', :id => params[:roio_set_list][:concert_id] and return
 
      else
        puts 'nothing'
      end #submit

    else
      note = "#{t('you_must_be_logged_in_to_add_a')} #{t('add_a_track_list').titleize}"
      begin
        redirect_to URI(request.referer).path + "?note=" + note
      rescue
        redirect_to :controller => 'index', :action => 'index' and return
      end # resuce
    end #
  end # cookies



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @roio_set_list = RoioSetList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roio_set_list_params
      params.require(:roio_set_list).permit(:set_list_id, :songs_id, :set_position,:concert_id, :orig_concert_id, :bootleg_id, :notes, :orig_bootleg_id, :track_times, :recorder)
    end



end
