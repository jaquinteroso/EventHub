class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, { confirmed: 0, waiting_list: 1 }

  validates :user_id, uniqueness: { scope: :event_id, message: "is already registered for this event" }
  validate :event_must_be_published, on: :create

  before_validation :assign_status, on: :create
  after_destroy :promote_waitlisted

  private

  def event_must_be_published
    return unless event
    unless event.published?
      errors.add(:event, "is not open for registration")
    end
  end

  def assign_status
    return unless event
    if event.spots_available > 0
      self.status = :confirmed
    else
      self.status = :waiting_list
    end
  end

  def promote_waitlisted
    if confirmed?
      next_in_line = event.registrations.waiting_list.order(:created_at).first
      next_in_line&.update(status: :confirmed)
    end
  end
end
