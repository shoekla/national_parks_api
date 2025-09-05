require 'rails_helper'

RSpec.describe Alert, type: :model do
  # Associations
  it { should belong_to(:park) }

  # Validations
  it { should validate_presence_of(:title) }
end
