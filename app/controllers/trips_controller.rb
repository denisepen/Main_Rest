class TripsController < ApplicationController

  def new
    @trip = Trip.create!(user_id: session[:user_id], date: Time.now)
     session[:trip_id] = @trip.id

     # session[:total] = Order.joins(:trip).joins(:meal).sum("price")
      redirect_to :root
    
  end

  def index
     @trips = Trip.all
  end

  def show
    @trip = Trip.find(session[:trip_id])
    session[:total] = Order.joins(:trip).where(trip_id: session[:trip_id]).joins(:meal).sum("price")
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

  private

  def trip_params
    params.require(:trip).permit(:user_id, :date, :comment)
  end
end
