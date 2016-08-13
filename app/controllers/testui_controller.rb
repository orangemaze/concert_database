class TestuiController < ApplicationController
  layout 'testui'
  def index

  end

  def show
    @data_result = Concert.find(params[:id])
  end
end
