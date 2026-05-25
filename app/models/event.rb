class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category
  belongs_to :venue
  
  has_many :registrations, dependent: :destroy
  has_many :attendees, through: :registrations, source: :user
  has_many :reviews, dependent: :destroy

  has_rich_text :description

  enum :state, { draft: 0, published: 1, ongoing: 2, completed: 3, cancelled: 4 }

  validates :title, presence: true
  validates :start_date, :end_date, presence: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validate :end_date_after_start_date
  validate :capacity_within_venue_limits

  after_initialize :set_default_state, if: :new_record?

  def spots_available
    max_capacity - registrations.confirmed.count
  end

  private

  def set_default_state
    self.state ||= :draft
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def capacity_within_venue_limits
    return if max_capacity.blank? || venue.blank?
    if max_capacity > venue.capacity_max
      errors.add(:max_capacity, "cannot exceed the venue's maximum capacity")
    end
  end
end
