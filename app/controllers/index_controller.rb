class IndexController < ApplicationController

  def index
    puts 'this'.blue
    @roios = Concert.all.limit(20) # commented for testing
  end

  def show
    @roios = Concert.find(params[:id])
  end

  private
    def set_index
      @roios = Concert.find(params[:id])
    end


end