class MembersController < ApplicationController
  layout 'testui'

  puts '=== members controller ==='.red

  def index
    # @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
    band = Band.find(params[:band_id])
    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(band.band_name).present? or (session[:admin].to_i == 1)
        @is_moderator = 'y'
      else
        redirect_to(index_index_path)
      end
    else
      redirect_to(index_index_path)
    end
  end



  def merge_members
    current_id = params[:id]
    merged_id = params[:merged_id]
    band_id = params[:band_id]
    # @band = Band.find(band_id)
    if @moderator_band_names.present?
      if session[:admin].to_i == 1 # or @moderator_band_names.has_value?(@band.band_name).present?

        update_band = "update band_members set member_id = '#{current_id}' where member_id = '#{merged_id}';"
        update_tour = "update tour_members set member_id = '#{current_id}' where member_id = '#{merged_id}';"

        puts update_band.magenta
        puts update_tour.magenta

        begin
          begin
            band_members = BandMember.find_by_sql(update_band)
          rescue
            band_members = BandMember.find_by_sql(update_band)
          end
        rescue
          # nada
        end

        begin
          begin
            tour_members = TourMember.find_by_sql(update_tour)
          rescue
            tour_members = TourMember.find_by_sql(update_tour)
          end
        rescue
          # nada
        end

        @data = "complete"
      else
        @data = "error"
      end
    else
      @data = "error"
    end

    render :layout => false
  end

  def update
    @member = Member.find(params[:id])
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, :notice => 'Member was successfully updated.' }
        format.json { render :show, :status => :ok, :location => @member }
      else
        format.html { render :edit }
        format.json { render :json => @member.errors, :status => :unprocessable_entity }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @member = Band.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:member_fname, :member_lname, :bio)
  end


end