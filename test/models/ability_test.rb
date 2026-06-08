require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  test "guest can read published events but not draft events" do
    ability = Ability.new(nil)

    assert ability.can?(:read, events(:published))
    assert ability.cannot?(:read, events(:draft))
  end

  test "regular user can manage own event lifecycle but not another user's event" do
    ability = Ability.new(users(:organizer))

    assert ability.can?(:update, events(:draft))
    assert ability.can?(:cancel, events(:draft))
    assert ability.cannot?(:update, events(:completed))
    assert ability.cannot?(:destroy, events(:draft))
  end

  test "regular user cannot manage categories venues users or reviews" do
    ability = Ability.new(users(:regular))

    assert ability.cannot?(:manage, categories(:technology))
    assert ability.cannot?(:manage, venues(:auditorium))
    assert ability.cannot?(:manage, users(:admin))
    assert ability.cannot?(:destroy, reviews(:completed_review))
  end

  test "admin can manage moderation resources" do
    ability = Ability.new(users(:admin))

    assert ability.can?(:manage, categories(:technology))
    assert ability.can?(:manage, venues(:auditorium))
    assert ability.can?(:manage, users(:regular))
    assert ability.can?(:destroy, reviews(:completed_review))
    assert ability.can?(:destroy, events(:draft))
  end
end
