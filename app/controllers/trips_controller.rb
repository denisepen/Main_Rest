class TripsController < ApplicationController
   # after_action :trip_complete, only: [:checkout]

  def new
    @trip = Trip.create!(user_id: session[:user_id], date: Time.now)
     session[:trip_id] = @trip.id
     session[:total] = @trip.total
      redirect_to :root
  end

  def index

    @sum_of_totals = 0
    if is_admin?
     @trips = Trip.all
   elsif current_user
     @trips = current_user.trips
   else
     redirect_to root_path
   end
  end

  def show
    trip = Trip.find_by(id: params[:id])
    if trip.id == session[:trip_id]
    @trip = Trip.find(session[:trip_id])
    session[:total] = @trip.total
    # session[:total] = Order.joins(:trip).where(trip_id: session[:trip_id]).joins(:meal).sum("price")
    # binding.pry
  else
    @trip = Trip.find_by(id: params[:id])
    # @trip_total = trip.total
  end
end


  def update
    @trip = Trip.find_by(id: session[:trip_id])
    @trip.update(trip_params)
  end

  def checkout
     if session[:total].to_i > 0
    render :checkout
    session[:total] = 0
    session.clear
   else
     flash[:notice] = "Your cart is empty. Please add a meal to your cart before checkout."
    redirect_to meals_path
   end
  end

  def trip_complete
     session[:total] = 0
     session.clear
     redirect_to :root
end

  private

  def trip_params
    params.require(:trip).permit(:user_id, :date, :comment)
  end
end
