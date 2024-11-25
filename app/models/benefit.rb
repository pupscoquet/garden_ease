class Benefit < ApplicationRecord
  belongs_to :project
  validates :description, presence: true, uniqueness: true
end
