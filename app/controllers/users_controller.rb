class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)


    if @user.save
      session[:user_id] = @user.id
      redirect_to new_trip_path
    else
      render :new
    end
  end

  def edit
    if is_admin?
    @user = User.find(params[:id])
    render 'edit'
  else
    redirect_to meals_path
end
  end

  def update
    @user = User.find(params[:id])
    @user = User.update(user_params)

  redirect_to user_path
  end

  def show
    if is_admin?
     @user = User.find(params[:id])
   elsif !is_admin? && current_user
       @user = User.find(session[:user_id])
   else
     redirect_to meals_path

  end
end

  def order_page
    @meals = current_user.meals
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
