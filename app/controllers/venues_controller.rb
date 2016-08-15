class VenuesController < ApplicationController
  layout 'testui'
  def index
    puts 'Roios'.blue
    @data_result = Venue.all.limit(200) # commented for testing
  end

  def show
    @data_result = Venue.find(params[:id])
  end

end