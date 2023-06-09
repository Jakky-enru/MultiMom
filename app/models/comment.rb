class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  validates :content, presence: true, length: {maximum: 200}
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
