require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Factories' do
    context 'Valid factory' do
      subject { create(:answer) }
      specify { should be_valid }
    end

    context 'Invalid factory' do
      subject { build(:invalid_answer) }
      specify { is_expected.not_to be_valid }
    end
  end

  describe 'Associations' do
    it { should belong_to(:response) }
    it { should belong_to(:questions) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:response) }
    it { should validate_presence_of(:question) }
  end

  describe 'Callbacks' do
  end

  describe 'ClassMethods' do
  end

  describe 'InstanceMethods' do
  end
end
