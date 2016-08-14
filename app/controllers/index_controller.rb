class IndexController < ApplicationController
  layout 'testui'
  def index
    puts 'Index'.blue



  end

  def show
    @data_result = Concert.find(params[:id])
  end

  def about

  end

  private
  def set_index
    @data_result = Concert.find(params[:id])
  end
end