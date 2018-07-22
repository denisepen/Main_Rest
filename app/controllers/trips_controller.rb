class TripsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def new
    @trip = Trip.create!(user_id: session[:user_id], date: Time.now)
     session[:trip_id] = @trip.id
     session[:total] = @trip.total
     @trip.status = "new"
      redirect_to :root
  end

  def index

    @sum_of_totals = 0
    if is_admin?

      # # if !params[:date].blank?
        if params[:date] == "Today"
          @trips = Trip.today
        elsif params[:date] == "This Week"
          @trips = Trip.this_week
        elsif params[:date] == "This Week"
          @trips = Trip.this_year
        else
          @trips = Trip.all
        end
      # # end

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
  else
    @trip = Trip.find_by(id: params[:id])
  end
end


  def update
    @trip = Trip.find_by(id: session[:trip_id])
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
  end

  def checkout
    @trip = Trip.find_by(id: session[:trip_id])
     if session[:total].to_i > 0
       @trip.date = Time.now
    session[:total] = 0
    @trip.status = "complete"
    redirect_to new_trip_path
    flash[:notice] = "Thank you for your order #{@trip.user.named}. Your order total is #{number_to_currency(@trip.total)}."
   else
     flash[:alert] = "Your cart is empty. Please add a meal to your cart before checkout."
    redirect_to meals_path
   end
  end


  private

  def trip_params
    params.require(:trip).permit(:user_id, :date, :comment)
  end
end
