class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :rentals

  validates :make, presence: true
  validates :model, presence: true
  validates :year_of_manufacture, presence: true,
  validates :description, presence: true
  validates :mot_certificate, presence: true
  validates :tax_details, presence: true
  validates :number_plate, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }
  validates :colour, presence: true
  validates :location_of_vehicle, presence: true
  validates :image_url, presence: true
end
