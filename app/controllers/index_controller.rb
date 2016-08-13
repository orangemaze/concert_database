class IndexController < ApplicationController

  def index
    puts 'Index'.blue



  end

  def show
    @data_result = Concert.find(params[:id])
  end

  private
  def set_index
    @data_result = Concert.find(params[:id])
  end
end