class MembersController < ApplicationController
  layout 'testui'

  puts '=== members controller ==='.red

  def index
    # @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Member.find(params[:id])
  end

  def merge_members
    current_id = params[:id]
    merged_id = params[:merged_id]
    band_id = params[:band_id]
    # @band = Band.find(band_id)
    if @moderator_band_names.present?
      if (session[:admin].to_i == 1) # or @moderator_band_names.has_value?(@band.band_name).present?

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
end