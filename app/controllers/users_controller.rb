class UsersController < ApplicationController

   before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
   before_action :correct_user, only: [:edit, :update]
   before_action :admin_user, only: [:destroy]

  

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated == true
  end


  def new
 	@user=User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @user.send_activation_email
      # UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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
    @users = User.where(activated: true).paginate(page: params[:page])
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User deleted"
    redirect_to users_path
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

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
