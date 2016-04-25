require 'rails_helper'

RSpec.describe Work, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it 'has a valid work factory' do
    FactoryGirl.create(:work).should_not be_valid
  end
end