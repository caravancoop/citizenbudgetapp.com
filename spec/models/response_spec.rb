require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'Factories' do
    context 'Valid factory' do
      subject { create(:response) }
      specify { should be_valid }
    end

    context 'Invalid factory' do
      subject { build(:invalid_response) }
      specify { is_expected.not_to be_valid }
    end
  end

  describe 'Associations' do
    it { should belong_to(:questionnaire) }
    it { should have_many(:answers) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:questionnaire) }
    it { should validate_presence_of(:initialized_at) }
    it { should validate_presence_of(:ip) }
  end

  describe 'Callbacks' do
  end

  describe 'ClassMethods' do
  end

  describe 'InstanceMethods' do
  end
end
