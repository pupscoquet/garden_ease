class Space < ApplicationRecord
  belongs_to :project
  validates :type_of_space, presence: true, uniqueness: true
end
