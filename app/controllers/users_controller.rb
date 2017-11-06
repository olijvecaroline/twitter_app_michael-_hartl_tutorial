class UsersController < ApplicationController

   before_action :logged_in_user, only: [:edit, :update, :index]
   before_action :correct_user, only: [:edit, :update]
  

  def show
  	@user=User.find(params[:id])


  end

  def new
 	@user=User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:succes] = "Profile successfully updated"
        redirect_to (@user)
      else
        render 'edit'
      end
  end

  def index
    @users=User.all
  end

  private
  
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #before filters:

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "please log in as #{@user.name}"
        redirect_to(root_url) 
      end
  end

end
