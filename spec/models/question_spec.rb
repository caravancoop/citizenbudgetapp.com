require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Factories' do
    context 'Valid factory' do
      subject { create(:question) }
      specify { should be_valid }
    end

    context 'Invalid factory' do
      subject { build(:invalid_question) }
      specify { is_expected.not_to be_valid }
    end
  end

  describe 'Associations' do
    it { should belong_to(:section) }
  end

  describe 'Validations' do
    it { should validate_inclusion_of(:critria).in_array(->(q){ q.section.criterion }).allow_blank }
  end

  describe 'Callbacks' do

    describe 'strip_title_and_extra' do
    end
  end

  describe 'ClassMethods' do
  end

  describe 'InstanceMethods' do
  end
end
