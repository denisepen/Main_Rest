class ReviewsController < ApplicationController


  def new
    @review = Review.new #(user_id: params[:user_id])
  end

  def create
    # @review = Review.new(review_params)
    if !params[:user_id] || !logged_in? 
      flash[:alert] = "Must be signed in to create review"
      redirect_to root_path
    elsif is_admin?
      flash[:alert] = "Admin can't create reviews!"
      redirect_to root_path
    elsif  params[:user_id]

      @user = User.find_by(id: params[:id])
      @review = @user.reviews.build(review_params)
      if @review.save
        respond_to do |format|
          # format.html { redirect_to reviews_path }
          format.json { render json: @review, status: 201}
        end

       else
        render :new
      end

  else
      @user = current_user
      @review = @user.reviews.build(review_params)
       if @review.save
         respond_to do |format|
           # format.html { redirect_to reviews_path }
           format.json { render json: @review, status: 201}
         end
       else
         render :new
       end
  end
end

  def show
    @review = Review.find_by(id: params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @review}
    end
  end

  def edit

    @review = Review.find(params[:id])
    if !is_admin? && current_user == @review.user
      if params[:user_id]
        user = User.find_by(id: params[:user_id])
        @review = user.reviews.find_by(id: params[:id])
        redirect_to user_reviews_path(user), alert: "Review not found" if @review.nil?
      else
        @review = Review.find(params[:id])
      end
    else
      flash[:alert] = "You can't edit this review!"
      redirect_to reviews_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    @user = @review.user
    respond_to do |format|
      format.html { redirect_to user_reviews_path(@user) }
      format.json { render json: @review}
    end
    # redirect_to user_reviews_path(@user)
  end

  def index
    # binding.pry

    if params[:user_id]
      @reviews = User.find(params[:user_id]).reviews
   else
      @reviews = Review.all
    end
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @reviews}
    end

  end

  def destroy
    @review = Review.find(params[:id])

    if !is_admin? && current_user == @review.user
      @review.destroy
      redirect_to reviews_path
    else
      redirect_to reviews_path
      flash[:alert] = "You can't delete this review!"
  end
end


  private

  def review_params
    params.require(:review).permit(:title, :comment, :date_posted, :user_id)
  end
end
