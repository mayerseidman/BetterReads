class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_id(auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    GroupsCreator.new(user).delay.create_and_populate!
    redirect_to groups_path, notice: "You have successfully logged in."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end
end
