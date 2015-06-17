class AddUserIdToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :user, index: true, foreign_key: true
  end
end


# by adding a column for user id in reviews this passed both tests. Why?

#   1) Review should belong to user
#      Failure/Error: it { is_expected.to belong_to :user }
#        Expected Review to have a belongs_to association called user (Review does not have a user_id foreign key.)
#      # ./spec/models/reviews_spec.rb:5:in `block (2 levels) in <top (required)>'

#   2) User should have many reviews
#      Failure/Error: it { is_expected.to have_many :reviews }
#        Expected User to have a has_many association called reviews (Review does not have a user_id foreign key.)
#      # ./spec/models/user_spec.rb:4:in `block (2 levels) in <top (required)>'

# Finished in 2.07 seconds (files took 5.31 seconds to load)
# 21 examples, 2 failures
