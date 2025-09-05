require 'rails_helper'

RSpec.describe Park, type: :model do
  # Associations
  it { should have_many(:alerts).dependent(:destroy) }

  # Validations
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }

  # Uniqueness validation
  subject { Park.new(code: "YNP", name: "Yosemite", states: [ "CA" ]) }
  it { should validate_uniqueness_of(:code) }
end
