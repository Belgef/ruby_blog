class Article < ApplicationRecord
  include Visible

  belongs_to :category
  has_many :comments, dependent: :destroy

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  self.per_page = 5

  acts_as_taggable_on :tags
end
