class OrdersController < ApplicationController

  def new
  if current_user
    @order = Order.create(meal_id: session[:meal_id], trip_id: session[:trip_id], date: Time.now)
    @order.trip.status = "pending"
    @order.id = session[:order_id]
    flash[:notice] = "Meal added to Order"
    redirect_to trip_path(current_trip)
  else
    flash[:notice] = "You must sign in to place order"
    redirect_to :root
  end
  end

  def index

    @user = User.find_by(id: session[:user_id])
    if @user.admin
      @orders = Order.all
    else
    @orders = User.find_by(id: session[:user_id]).orders
  end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.delete
    redirect_to trip_path(session[:trip_id])
  end

  def checkout
    @order.trip.status = "complete"
    render :checkout
  end


end
