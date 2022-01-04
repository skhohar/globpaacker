class Navigation < ApplicationRecord
  belongs_to :user
  has_many :steps
  validates :user_id, presence: true
  validates :place_id, presence: true
  validates :starting_coordinate, presence: true
  validates :ending_coordinate, presence: true
  validates :done, presence: true
  validates :time_deadline, presence: true
  validates :date, presence: true
end
