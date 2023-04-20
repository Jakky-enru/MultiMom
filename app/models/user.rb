class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { parent: 0, child: 1, admin: 2 }, _prefix: true

  has_many :blogs
  has_many :comments
  has_many :favorites, dependent: :destroy
  validates :role, presence: true

  validates :name, presence: true, length: { maximum: 300 }
  validates :email, presence: true, length: { maximum: 300 }
  validates :password, length: { minimum: 6, maximum: 300 }, if: :password_required?, allow_blank: true

  def self.guest_parent
    find_or_create_by!(email: 'guest_parent@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(親)"
      user.role = "parent"
    end
  end

  def self.guest_child
    find_or_create_by!(email: 'guest_child@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(子)"
      user.role = "child"
    end
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(管理者)"
      user.role = "admin"
    end
  end
end
