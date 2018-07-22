class OrdersController < ApplicationController

  def new
    if current_user
      @order = Order.create(meal_id: session[:meal_id], trip_id: session[:trip_id], date: Time.now)
      @order.trip.status = "pending"
      @order.id = session[:order_id]
      flash[:notice] = "Meal added to Order"
      redirect_to trip_path(current_trip)
    else
      flash[:alert] = "You must sign in to place order"
      redirect_to :root
    end
  end



  def destroy
    @order = Order.find(params[:id])
    @order.delete
    redirect_to trip_path(session[:trip_id])
  end

end
