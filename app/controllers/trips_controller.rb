class TripsController < ApplicationController

  def add_meal
    @trip = Trip.create!(user_id: session[:user_id], date: Time.now)
     session[:trip_id] = @trip.id
      redirect_to new_order_path
     # raise session.inspect
     # binding.pry
  # raise params.inspect
    # @order = Order.create(meal_id: session[:meal_id], user_id: session[:user_id], date: Time.now)
    # @order = Order.create(meal_id: session[:meal_id], trip_id: session[:trip_id], date: Time.now)

    # binding.pry
    # @order.id = session[:order_id]
    # raise session.inspect
    # flash[:notice] = "Meal added to Order"

    # redirect_to trip_path(@trip)
  end

  def index
    # @trips =
  end

  def show
    @trip = Trip.find(session[:trip_id])
  end

  def total
    # binding
    @user = Order.find_by(id: session[:user_id])
    @trip_total = Trip.joins(:order).joins(:meal).sum("price")
    @trip_total = session[:total]
  end

  def checkout
    render :checkout
  end
end
