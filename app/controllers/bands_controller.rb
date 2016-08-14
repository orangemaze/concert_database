class BandsController < ApplicationController
  layout 'testui'
  def index
    puts 'Bands'.blue
    @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Band.find(params[:id])
  end
end