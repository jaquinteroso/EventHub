require "test_helper"

module Admin
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test "regular user cannot access admin users" do
      sign_in users(:regular)

      get admin_users_url
      assert_redirected_to root_path
    end

    test "admin can access admin users" do
      sign_in users(:admin)

      get admin_users_url
      assert_response :success
    end

    test "admin can update user role" do
      sign_in users(:admin)

      patch admin_user_url(users(:regular)), params: {
        user: {
          full_name: users(:regular).full_name,
          email: users(:regular).email,
          role: "admin"
        }
      }

      assert_redirected_to admin_users_path
      assert users(:regular).reload.admin?
    end
  end
end
