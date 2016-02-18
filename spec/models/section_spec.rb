require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'Factories' do
    context 'Valid factory' do
      subject { create(:section) }
      specify { should be_valid }
    end

    context 'Invalid factory' do
      subject { build(:invalid_section) }
      specify { is_expected.not_to be_valid }
    end
  end

  describe 'Associations' do
    it { should belong_to(:questionnaire) }
    it { should have_many(:questions) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:group) }
    it { should validate_inclusion_of(:group).in_array(Section::GROUPS).allow_blank }
  end

  describe 'Callbacks' do

    describe 'set_default_group' do
    end

    describe 'touch_questionnaire' do
    end
  end

  describe 'ClassMethods' do
  end

  describe 'InstanceMethods' do
  end
end
