require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  describe 'Factories' do
    context 'Valid factory' do
      subject { create(:questionnaire) }
      specify { should be_valid }
    end

    context 'Invalid factory' do
      subject { build(:invalid_questionnaire) }
      specify { is_expected.not_to be_valid }
    end
  end

  describe 'Associations' do
    it { should belong_to(:organization) }
    it { should have_one(:google_api_authorization) }
    it { should have_many(:sections) }
    it { should have_many(:responses) }
    it { should have_many(:answers) }
  end

  describe 'Validations' do
    # TODO
  end

  describe 'Callbacks' do
  end

  describe 'ClassMethods' do
  end

  describe 'InstanceMethods' do
  end
end
