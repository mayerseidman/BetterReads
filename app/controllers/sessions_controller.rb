class SessionsController < ApplicationController
    # def create
    #     render :text => request.env['omniauth.auth'].to_yaml
    # end


  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider(auth["provider"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, notice: "You have successfully logged in."
  end

  def destroy
    session[:current_user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end
  
end

