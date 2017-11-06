class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
  		log_in(@user)
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
  	else
  		flash.now[:danger] = "You are not logged in"
  		render 'new'
  		
  	end
  end

  def destroy
  #   user = User.find_by(id: session[:user_id])
    log_out if logged_in?
    redirect_to root_url
    # flash[:success] = "#{user.name} is logged out"
  end
end
