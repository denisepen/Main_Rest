class MealsController < ApplicationController

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    respond_to do |format|
      if @meal.save
        session[:meal_id] = @meal.id
      # redirect_to meals_path
          format.html { redirect_to meals_path }
          format.json  #{ render json: @meals}
    else
      render :new
      end
    end
  end

  def most_popular
    @meal = Meal.meal_count
  end 

  def index

    if !params[:category].blank? && !params[:calorie_count].blank?
      @meals = Meal.by_category(params[:category]).low_cal
    elsif !params[:category].blank? && params[:calorie_count].blank?
      @meals = Meal.by_category(params[:category])
     elsif  !params[:calorie_count].blank?
       @meals = Meal.low_cal
    else
    # if no filters are applied, show all posts
    @meals = Meal.all

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @meals}
    end

    end
  end



  def show
    @meal = Meal.find(params[:id])
    session[:meal_id] = @meal.id
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @meal, status: 200}
    end
    # render json: @meal, status: 200
  end

  def edit
    if current_user.admin == true
    @meal = Meal.find(params[:id])
    render :edit
  else
    redirect_to meals_path
    end
  end

  def update
     # binding.pry
    @meal = Meal.find(params[:id])
    @meal.update(meal_params)
    respond_to do |format|
      format.html { redirect_to meal_path(@meal) }
      format.json { render json: @meal}
    end

    # redirect_to meal_path(@meal)
  end

  def destroy
    @meal = Meal.find(params[:id])

    if current_user.admin
    @meal.destroy
    redirect_to meals_path
    end
  end



private

      def meal_params
         params.require(:meal).permit(:name, :price, :category, :calorie_count, :description)
       end
      end
