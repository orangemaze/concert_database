class TourMemberController < ApplicationController
  layout 'testui'

  protect_from_forgery :except => :destroy

  def delete_member_from_tour
    tours_id = params[:tours_id]
    member_id = params[:member_id]

    hmm =  TourMember.delete_all(:tours_id => tours_id, :member_id => member_id).inspect

    puts "delete tour member".blue


    @tour = Tour.find(tours_id)
    puts 'edit'.blue
    puts @tour.inspect.red
    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@tour.band_name[0]).present? or (session[:admin].to_i == 1)
        @is_moderator = 'y'
      else
        redirect_to("/index")
      end
    else
      redirect_to("/index")
    end




    render :layout => false
  end


  def destroy
    @tour_member.destroy
    respond_to do |format|
      format.html { redirect_to URI(request.referer).path, :notice => 'Album tours was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



end