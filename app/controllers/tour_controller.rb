class TourController < ApplicationController
  layout 'testui'
  def index
    puts 'Roios'.blue
    @data_result = Tour.all.limit(200) # commented for testing
  end

  def show
    @data_result = Tour.find(params[:id])
  end

end