class Park < ApplicationRecord
  has_many :alerts, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end
