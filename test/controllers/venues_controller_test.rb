require "test_helper"

class VenuesControllerTest < ActionDispatch::IntegrationTest
  test "guest should get index" do
    get venues_url
    assert_response :success
  end

  test "regular user cannot create venue" do
    sign_in users(:regular)

    assert_no_difference("Venue.count") do
      post venues_url, params: { venue: { name: "Lab 1", address: "Building C", capacity_max: 20 } }
    end

    assert_redirected_to root_path
  end

  test "admin can create venue" do
    sign_in users(:admin)

    assert_difference("Venue.count") do
      post venues_url, params: { venue: { name: "Lab 1", address: "Building C", capacity_max: 20 } }
    end

    assert_redirected_to venue_path(Venue.order(:created_at).last)
  end
end
