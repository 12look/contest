require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :institution }

  it 'has a valid user factory' do
    FactoryGirl.build(:user).should be_valid
  end

  it 'has a invalid user name' do
    FactoryGirl.build(:user, :fail_name).should_not be_valid
  end

  it 'has a invalid user last_name' do
    FactoryGirl.build(:user, :fail_last_name).should_not be_valid
  end

  it 'has a invalid institution' do
    FactoryGirl.build(:user, :fail_institution).should_not be_valid
  end
end
