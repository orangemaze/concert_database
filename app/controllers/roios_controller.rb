class RoiosController < ApplicationController

  def index
    puts 'Roios'.blue
    @roios = Roio.all.limit(20) # commented for testing
  end

  def show
    @roios = Roio.find(params[:id])
  end

  private
  def set_index
    @roios = Roio.find(params[:id])
  end


end