class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :name, :description, :difficulty, :duration, presence: true
end
