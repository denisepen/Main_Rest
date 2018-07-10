class OrdersController < ApplicationController

  def add_meal

  # raise params.inspect
    @order = Order.create(meal_id: session[:meal_id], user_id: session[:user_id], date: Time.now)

    # binding.pry
    @order.id = session[:order_id]
    # raise session.inspect
    flash[:notice] = "Meal added to Order"
    redirect_to orders_path
  end

  def index

    @user = User.find_by(id: session[:user_id])
    if @user.admin
      @orders = Order.all
    else
    @orders = User.find_by(id: session[:user_id]).orders

    session[:total] = Order.joins(:user).joins(:meal).sum("price")
  end
    return @order_total = Order.joins(:user).joins(:meal).sum("price")
  end

  def destroy
    @order = Order.find(params[:id])
    @order.delete
    redirect_to orders_path

  end

  def total
    # binding
    @user = Order.find_by(id: session[:user_id])
    @order_total = Order.joins(:user).joins(:meal).sum("price")
    @order_total = session[:total]
  end

  def checkout
    # flash[:thanks] = "Thank you. Your order total is $#{session[:total]}. Have a great day!"
    render :checkout
  end


end
