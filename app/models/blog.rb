class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[content]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[blog]
  end
end
