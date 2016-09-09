class MembersController < ApplicationController
  layout 'testui'

  puts '=== members controller ==='.red

  def index
    # @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Member.find(params[:id])
  end

  def merge_members
    render :layout => false
  end
end