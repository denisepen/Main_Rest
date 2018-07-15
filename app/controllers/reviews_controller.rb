class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    if !is_admin
    @review = Review.create(review_params)
    redirect_to :root
  else
    flash[:notice] = "Admin can't create reviews!"
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def edit
    @review = Review.find_by(user_id: params[:user_id])
    if !is_admin? && current_user == @review.user
      render 'edit'
    else
      flash[:notice] = "You can't edit this review!"
      redirect_to reviews_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    @user = @review.user
    redirect_to user_path(@user)
  end

  def index
    @review = Review.all
  end


  private

  def review_params
    params.require(:review).permit(:title, :title, :date_posted, :user_id)
  end
end
