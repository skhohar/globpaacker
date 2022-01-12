class Step < ApplicationRecord
  belongs_to :navigation
  belongs_to :place

  # STATUS = ["proposed", "upcoming", "rejected", "visited"]
  validates :visited, inclusion: { in: [ true, false ] }
end
