class User < ApplicationRecord
  has_many :organized_events, class_name: 'Event', foreign_key: 'user_id', dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :events, through: :registrations
  has_many :reviews, dependent: :destroy

  enum :role, { regular: 0, admin: 1 }

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
end
