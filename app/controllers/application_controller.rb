# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #before_filter :authorize, :except => login
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
protected
  def authorize(id = nil)
    unless session[:author] && auth = Author.find_by_id(session[:author].id)
      redirect_to :controller => 'admin', :action => 'login'
    end
    if id
      unless auth.id == id
        flash[:error] = 'No puedes modificar cosas que no sean tuyas ^^\''
        redirect_to :controller => 'admin'
      end
    end
  end
end
