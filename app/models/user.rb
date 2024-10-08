class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # has_many :vehicles, dependent: :destroy
  has_many :rentals, dependent: :destroy
  # has_many :payment_details, dependent: :destroy
end
