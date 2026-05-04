class Venue < ApplicationRecord
  has_many :events, dependent: :restrict_with_error

  validates :name, presence: true
  validates :capacity_max, presence: true, numericality: { greater_than: 0 }
end
