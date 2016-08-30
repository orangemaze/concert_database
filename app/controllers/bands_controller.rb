class BandsController < ApplicationController
  layout 'testui'

  puts '=== band controller ==='.red

  def index
    @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Band.find(params[:id])

    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@data_result.band_name).present?
        @is_moderator = 'y'
      else
        @is_moderator = 'n'
      end
    else
      @is_moderator = 'n'
    end
  end

  def edit
    puts '== bands edit =='
    @moderator_band_names.inspect.green
    puts '== bands edit =='
    @data_result = Band.find(params[:id])

    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@data_result.band_name).present?
        @is_moderator = 'y'
      else
        redirect_to("/index")
      end
    else
      redirect_to("/index")
    end





  end
end