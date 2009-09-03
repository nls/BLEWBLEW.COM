class FeedbackController < ApplicationController
  def index
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if verify_recaptcha && @feedback.save
      flash[:notice] = 'El feedback fue enviado correctamente.'
    end
    redirect_to '/feedback'
  end
end
