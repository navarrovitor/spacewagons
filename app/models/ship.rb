class Ship < ApplicationRecord
  belongs_to :user
  has_many :parts, through: :users
  validates :name, uniqueness: true
end
