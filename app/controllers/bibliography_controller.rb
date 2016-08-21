class BibliographyController < ApplicationController
  layout 'testui'
  def index
    @data_result = Bibliography.all
  end

  def show
    @data_result = Bibliography.find(params[:id])
  end

end