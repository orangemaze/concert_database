class RoiosController < ApplicationController

  def index
    puts 'Roios'.blue
    @data_result = Roio.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Roio.find(params[:id])
  end

  private
  def set_index
    @data_result = Roio.find(params[:id])
  end


end