class SessionsController < ApplicationController


  def signin
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.find_by(email: params[:user][:email])
    # binding.pry
     if @user
       if  @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id

      redirect_to :root
      # user_path(@user)
    else
    flash[:error] = "Email or password is invalid"
    render :signin
    end
   end
  end

  def destroy
    # session.delete :user_id
    # session.delete :total
    # session.delete :order_id
    session[:user_id] = nil
    session[:order_id] = nil
    session[:total] = nil

    # reset_session
    redirect_to root_path
  end
end
