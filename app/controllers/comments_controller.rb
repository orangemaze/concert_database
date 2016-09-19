class CommentsController < ApplicationController
  layout 'testui'

  def index

  end

  def show

  end

  def new
    if cookies[:user_id].present?
      puts 'new'.blue
      @roio = Review.new
    else

      note = t('you_must_be_logged_in_to_add_a_review').html_safe
      redirect_to URI(request.referer).path + "?note=" + note
    end
  end

end