class SuggestController < ApplicationController

  def index
    term = ActionController::Base.helpers.sanitize(params[:term])
    @search_action = ActionController::Base.helpers.sanitize(params[:search_action])

    @suggest_result = ApplicationController.helpers.search_suggest(term, @search_action)

    render :layout => false
  end

end