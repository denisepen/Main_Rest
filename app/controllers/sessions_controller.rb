class SessionsController < ApplicationController


  def signin
    @user = User.new
  end

  def create
    if auth
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
           u.image = auth['info']['image']
        end
         @user.save(validate: false)
       session[:user_id] = @user.id
       redirect_to new_trip_path
    else
    @user = User.find_by(email: params[:user][:email])
     if @user &&
         @user.authenticate(params[:user][:password])

      session[:user_id] = @user.id
      # session[:total] = 0
      redirect_to new_trip_path
    else
    flash[:notice] = "Email or password is invalid"
    redirect_to signin_path
    end
   end

 end


  def destroy
    session[:user_id] = nil
    # session[:trip_id] = nil
    session[:total] = 0
    @trip = Trip.find_by(id: session[:trip_id])
    # binding.pry
    if @trip.status = "new"
      @trip.delete
    end
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
