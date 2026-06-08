require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "guest cannot register for event" do
    assert_no_difference("Registration.count") do
      post event_registrations_url(events(:published))
    end

    assert_redirected_to new_user_session_path
  end

  test "regular user can register for published event" do
    sign_in users(:organizer)

    assert_difference("Registration.count") do
      post event_registrations_url(events(:published))
    end

    assert_redirected_to event_path(events(:published))
  end

  test "regular user can cancel own registration" do
    sign_in users(:regular)

    assert_difference("Registration.count", -1) do
      delete event_registration_url(events(:published), registrations(:upcoming))
    end

    assert_redirected_to event_path(events(:published))
  end
end
