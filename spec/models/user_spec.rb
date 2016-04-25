require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :institution }

  it 'has a valid user factory' do
    FactoryGirl.build(:user).should be_valid
  end

  it 'has a not valid user name' do
    FactoryGirl.build(:user, :fail_name).should_not be_valid
  end
end
