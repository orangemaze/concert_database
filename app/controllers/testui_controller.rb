class TestuiController < ApplicationController
  layout 'testui'
  def index

  end

  def show
    @data_result = Concert.find(params[:id])
  end

  def roio_details
    @data_result = Roio.find(params[:id])
    render :layout => false
  end
end
