class Group < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :posts
  has_many :group_relationship
  has_many :members, through: :group_relationship, source: :user
end
