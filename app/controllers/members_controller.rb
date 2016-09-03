class MembersController < ApplicationController
  layout 'testui'

  puts '=== band controller ==='.red

  def index
    # @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    @data_result = Member.find(params[:id])
  end
end