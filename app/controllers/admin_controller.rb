class AdminController < ApplicationController
  def index
    authorize
  end

  def login
    if request.post?
      author = Author.authenticate(params[:user], params[:password])
      if author
        session[:author] = author
        redirect_to(:action => "index")
      else
        flash.now[:error] = "Usuario/password incorrecto"
      end
    end
  end

  def logout
    session[:author] = nil
    flash[:notice] = "Logout exitoso ;)"
    redirect_to(:action => "login")
  end
end
