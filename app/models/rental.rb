class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  validates :hire_start_date, :hire_end_date, :charge, presence: true

end
