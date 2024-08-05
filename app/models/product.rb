class Product < ApplicationRecord
  validates :name,
            :description,
            presence: true,
            length: { minimum: 1 },
            on: :create
  validates :price,
            presence: true
end
