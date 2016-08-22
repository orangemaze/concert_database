class BibliographyController < ApplicationController
  layout 'testui'
  def index
    @data_result = Bibliography.all
  end

  def show
    @data_result = Bibliography.find(params[:id])
  end

  def new
    @bibliography = Bibliography.new(bibliography_params)
  end

  def edit

  end

  def create
    @bibliography = Bibliography.new(bibliography_params)

    respond_to do |format|
      if @bibliography.save
        format.html { redirect_to @bibliography, :notice => 'Bibliography was successfully created.' }
        format.json { render :action => 'show', :status => :created, :location => @bibliography }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @bibliography.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def bibliography_params
    params.permit(:title, :bibliography, :user_id, :time_entered, :amazon_ad)
  end



end