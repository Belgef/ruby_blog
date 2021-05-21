class Article < ApplicationRecord
  include Visible

  belongs_to :category
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  self.per_page = 2

  acts_as_taggable_on :tags
end
