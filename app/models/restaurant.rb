class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user

  def build_review(current_user, review_params, restaurant)
   review = Review.new(review_params)
   review.user_id = current_user.id
   review.restaurant_id = restaurant.id
   review
  end
end
