class Product < ApplicationRecord
  validates :name,
            :description,
            presence: true,
            length: { minimum: 1 },
            on: :create
  validates :price,
            presence: true

  has_many :cart_items
  has_many :users, through: :cart_items
end
