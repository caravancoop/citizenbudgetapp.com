require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'Factories' do
    context 'Valid factory' do
      subject { create(:organization) }
      specify { should be_valid }
    end

    context 'Invalid factory' do
      subject { build(:invalid_organization) }
      specify { is_expected.not_to be_valid }
    end
  end

  describe 'Associations' do
    it { should have_many(:admin_users) }
    it { should have_many(:questionnaires) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Callbacks' do
  end

  describe 'ClassMethods' do
  end

  describe 'InstanceMethods' do
  end
end
