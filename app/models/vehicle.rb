class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :rentals

  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :description, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }
  validates :colour, presence: true
  validates :location, presence: true
  validates :image_url, presence: true
end
