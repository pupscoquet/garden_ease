class Picture < ApplicationRecord
  belongs_to :project
  validates :url, presence: true, uniqueness: true
end
