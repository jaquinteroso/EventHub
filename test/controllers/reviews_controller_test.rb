require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "regular user can review attended completed event" do
    sign_in users(:regular)

    assert_difference("Review.count") do
      post event_reviews_url(events(:completed)), params: {
        review: {
          rating: 4,
          comment: "Helpful event."
        }
      }
    end

    assert_redirected_to event_path(events(:completed))
  end

  test "regular user cannot delete review" do
    sign_in users(:regular)

    assert_no_difference("Review.count") do
      delete event_review_url(events(:completed), reviews(:completed_review))
    end

    assert_redirected_to root_path
  end

  test "admin can delete review" do
    sign_in users(:admin)

    assert_difference("Review.count", -1) do
      delete event_review_url(events(:completed), reviews(:completed_review))
    end

    assert_redirected_to event_path(events(:completed))
  end
end
