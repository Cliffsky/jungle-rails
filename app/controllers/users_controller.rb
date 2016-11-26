class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      pp user
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
      flash.alert = "Make sure password and password confirmation fields match, and that password is minimum 8 characters long."
    end
  end

  private

  def user_params
    puts params
    params[:user][:email] = params[:user][:email].downcase
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end