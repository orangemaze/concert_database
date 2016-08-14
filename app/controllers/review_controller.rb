class ReviewController < ApplicationController
  layout 'testui'
  def index

  end

  def show

  end

  def testui_comments
    @data_result = Concert.find(params[:id])
  end

end