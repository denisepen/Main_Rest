class TripsController < ApplicationController
  after_action :trip_complete, only: [:checkout]

  def new
    @trip = Trip.create!(user_id: session[:user_id], date: Time.now)
     session[:trip_id] = @trip.id
      redirect_to :root

  end

  def index

    if is_admin?
     @trips = Trip.all
     # binding.pry
   elsif current_user
     @trips = current_user.trips
     # @trip_total = @trip.
   else
     redirect_to root_path
   end
  end

  def show
    trip = Trip.find_by(id: params[:id])
    if trip.id == session[:trip_id]
    @trip = Trip.find(session[:trip_id])
    session[:total] = Order.joins(:trip).where(trip_id: session[:trip_id]).joins(:meal).sum("price")
    # binding.pry
  else
    @trip = Trip.find_by(id: params[:id])
    @trip_total = trip.total
  end
end

  # def total
  #   # binding
  #   @user = Order.find_by(id: session[:user_id])
  #   @trip_total = Trip.joins(:orders).joins(:meals).sum("price")
  #   binding.pry
  #   @trip_total = session[:total]
  # end

  def update
    @trip = Trip.find_by(id: session[:trip_id])
    # session[:total] = Order.joins(:trip).joins(:meal).sum("price")
    @trip.update(trip_params)
  end

  def checkout
    render :checkout
  end

  def trip_complete
    session[:total] = 0
    session.clear
  end

  private

  def trip_params
    params.require(:trip).permit(:user_id, :date, :comment)
  end
end
