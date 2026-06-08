require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "guest should get index" do
    get categories_url
    assert_response :success
  end

  test "regular user cannot create category" do
    sign_in users(:regular)

    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Music", description: "Concerts" } }
    end

    assert_redirected_to root_path
  end

  test "admin can create category" do
    sign_in users(:admin)

    assert_difference("Category.count") do
      post categories_url, params: { category: { name: "Music", description: "Concerts" } }
    end

    assert_redirected_to category_path(Category.order(:created_at).last)
  end
end
