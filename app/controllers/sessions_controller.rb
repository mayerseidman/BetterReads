class SessionsController < ApplicationController
    # def create
    #     render :text => request.env['omniauth.auth'].to_yaml
    # end


  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider(auth["provider"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to listgroups_path, notice: "You have successfully logged in."
  end

  def destroy
  session[:user_id] = nil
  redirect_to root_url, notice: "Signed out."
end
  
end
