require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:job) }
  it { should validate_presence_of(:status) }
end
