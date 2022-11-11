class Product < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :prince, presence: true
end
