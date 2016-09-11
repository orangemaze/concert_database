class ConcertsController < ApplicationController
  layout 'testui'

  before_filter :announce_controller

  def announce_controller
    puts '=== concert controller ==='.magenta
  end

  def index
    puts 'Concerts'.blue
    # @data_result = Concert.all.limit(20) # commented for testing
  end

  def new

  end


  def show
    @data_result = Concert.find(params[:id])
    puts ' == show =='.green
    puts flash.inspect.to_s.magenta
    puts '-- flash above --'

    @note = params[:note].present? ? params[:note] : ''


    @data_result.inspect.red
    if @moderator_band_names.present?
      if (@moderator_band_names.has_value?(@data_result.band_name[0]).present?) or (session[:admin].to_i == 1)
        @is_moderator = 'y'
      else
        @is_moderator = 'n'
      end
    else
      @is_moderator = 'n'
    end
  end

  def roio_details
    @data_result = Roio.find(params[:id])
    render :layout => false
  end

  private
  def set_index
    @data_result = Concert.find(params[:id])
  end


end