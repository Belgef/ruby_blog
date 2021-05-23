class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  has_many :articles, dependent: :destroy
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def assign_default_role
    self.add_role(:client) if self.roles.blank?
  end

  def admin?
    has_role?(:admin)
  end
  
  def client?
    has_role?(:client)
  end 
end
