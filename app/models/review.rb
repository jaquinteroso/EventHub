class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  validate :user_attended_completed_event

  private

  def user_attended_completed_event
    return unless event && user
    registration = user.registrations.find_by(event: event, status: :confirmed)
    unless registration && event.completed?
      errors.add(:base, "You can only review a completed event that you attended.")
    end
  end
end
