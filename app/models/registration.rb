class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, { confirmed: 0, waiting_list: 1 }

  validates :user_id, uniqueness: { scope: :event_id, message: "is already registered for this event" }
end
