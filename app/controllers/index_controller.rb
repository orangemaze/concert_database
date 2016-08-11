class IndexController < ApplicationController

  def index
    puts 'this'.blue
    @roios = Concert.all.limit(200) # commented for testing
  end

end