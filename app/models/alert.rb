class Alert < ApplicationRecord
  belongs_to :park

  validates :title, presence: true
end
