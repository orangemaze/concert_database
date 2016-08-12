class CountriesController < ApplicationController

  def index
    puts 'Countries'.blue
    @data_result = Country.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Country.find(params[:id])
  end
end