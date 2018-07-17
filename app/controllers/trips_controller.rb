class TripsController < ApplicationController
  after_action :trip_complete, only: [:checkout]

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
    render :checkout
  end

  def trip_complete
    session[:total] = 0
     session.clear
    # redirect_to new_trip_path
  end

  private

  def trip_params
    params.require(:trip).permit(:user_id, :date, :comment)
  end
end
