class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
  @restaurant = Restaurant.find(params[:restaurant_id])
  @review = @restaurant.build_review(current_user, review_params, @restaurant)

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        flash[:notice] = "has reviewed this restaurant already"
        redirect_to restaurants_path 
        
      else
        # Why would we render new again?  What else could cause an error?
        render :new
      end
    end
  end



  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
