class Category < ApplicationRecord
  has_many :articles

  validates :name, presence: true
  validates :desc, presence: true, length: { minimum: 10 }
end
