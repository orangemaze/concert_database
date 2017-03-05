class RoioSetListsController < ApplicationController
  before_action :set_comment, :only => [:show, :edit, :update, :destroy]
  layout 'testui'
  require 'similar_text'

  def new
    if cookies[:user_id].present?
      puts '--   roio set lists : new'.magenta
      bootleg_id = params[:roio_id]
      @roio = Roio.find(bootleg_id)
      @roio_set_list = RoioSetList.new

      if params[:submit] == 'Submit'
        puts '-> the fun <-'
        set_1 = params[:set_1]
        set_2 = params[:set_2]
        set_e = params[:set_e]

        # puts set_1.magenta

        # work through first set
        set_1_array = params[:set_1].split( /\r?\n/ )
        puts set_1_array.inspect.magenta
        set_1_array.each do |v|
          puts v.to_s.red
          songs = Song.where("song_name like ?", "%#{v}%")
          songs.each do |y|
            puts y.song_name.green
            if  (v.to_s.similar(y.song_name)) == 100.0
              puts 'selected'
            else
              puts 'not'
            end  

          end
        end # each

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
end
