require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "guest should get index" do
    get events_url
    assert_response :success
    assert_includes response.body, events(:published).title
    assert_not_includes response.body, events(:draft).title
  end

  test "guest should view published event" do
    get event_url(events(:published))
    assert_response :success
  end

  test "guest should not view draft event" do
    get event_url(events(:draft))
    assert_redirected_to root_path
    assert_equal "You are not authorized to perform that action.", flash[:alert]
  end

  test "regular user can create event" do
    sign_in users(:regular)

    assert_difference("Event.count") do
      post events_url, params: {
        event: {
          title: "New User Event",
          start_date: 2.days.from_now,
          end_date: 2.days.from_now + 1.hour,
          max_capacity: 5,
          category_id: categories(:technology).id,
          venue_id: venues(:auditorium).id
        }
      }
    end

    assert_redirected_to event_path(Event.order(:created_at).last)
    assert_equal users(:regular), Event.order(:created_at).last.organizer
  end

  test "regular user cannot edit another user's event" do
    sign_in users(:regular)

    get edit_event_url(events(:draft))
    assert_redirected_to root_path
  end

  test "organizer can cancel own event" do
    sign_in users(:organizer)

    patch cancel_event_url(events(:published))
    assert_redirected_to event_path(events(:published))
    assert events(:published).reload.cancelled?
  end

  test "admin can delete any event" do
    sign_in users(:admin)

    assert_difference("Event.count", -1) do
      delete event_url(events(:draft))
    end

    assert_redirected_to events_path
  end
end
