class ConcertsController < ApplicationController
  layout 'testui'
  def index
    puts 'Concerts'.blue
    @data_result = Concert.all.limit(20) # commented for testing
  end

  def show
    @data_result = Concert.find(params[:id])
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