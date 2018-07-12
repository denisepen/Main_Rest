class SessionsController < ApplicationController


  def signin
    @user = User.new
  end

  def create

    @user = User.find_by(email: params[:user][:email])
     if @user
       if  @user.authenticate(params[:user][:password])

      session[:user_id] = @user.id
      session[:total] = 0
       # binding.pry
      redirect_to new_trip_path
    else
       # binding.pry
    flash[:notice] = "Email or password is invalid"
    redirect_to :signin
    end
   end
  end

  def destroy
    # session.delete :user_id
    # session.delete :total
    # session.delete :order_id
    session[:user_id] = nil
    session[:trip_id] = nil
    session[:total] = 0

    # reset_session
    redirect_to root_path
  end
end
