class UsersController < ApplicationController

  def index
    if  is_admin? || !current_user
      @users = User.all
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @users}
      end
    else
      redirect_to :root
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      # redirect_to new_trip_path
      respond_to do |format|
        format.html { redirect_to new_trip_path }
        format.json { render json: @user}
      end
    else
      render :new
    end
  end

  def edit
    if !is_admin?
    @user = User.find(params[:id])
    render 'edit'
  else
    redirect_to meals_path
end
  end

  def update
    @user = User.find(params[:id])
    @user = User.update(user_params)
    respond_to do |format|
      format.html { redirect_to user_path }
      format.json { render json: @user}
    end
    # redirect_to user_path
  end

  def show
    respond_to do |format|
      if is_admin?
       @user = User.find(params[:id])
         format.html { render :show }
         format.json  { render json: @user}
     elsif !is_admin? && current_user
         # @user = User.find(session[:user_id])
         @user = User.find(session[:user_id])
         format.html { render :show }
         format.json  { render json: @user }

     else
       redirect_to meals_path
     end

  end
end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
