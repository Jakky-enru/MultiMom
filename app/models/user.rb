class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { parent: 0, child: 1, admin: 2 }, _prefix: true

  has_many :blogs
  has_many :comments
  has_many :favorites, dependent: :destroy
end
