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
    it { should validate_inclusion_of(:widget).in_array(Question::WIDGETS).allow_blank }
    it { should validate_numericality_of(:unit_amount).allow_nil }

    # HTML attribute validations.
    it { should validate_numericality_of(:size).allow_nil }
    it { should validate_numericality_of(:maxlength).allow_nil }
    it { should validate_numericality_of(:rows).allow_nil }
    it { should validate_numericality_of(:cols).allow_nil }

    # Budgetary widget validations.
    it { should validate_presence_of(:unit_amount) }
    it { should validate_presence_of(:default_value) }
    it { should validate_presence_of(:options) }
    it { should validate_presence_of(:labels) }
    it { should validate_numericality_of(:unit_amount).allow_nil }
    it { should validate_numericality_of(:default_value).allow_nil }

    # Slider validations.
    it { should validate_presence_of(:minimum_units) }
    it { should validate_presence_of(:maximum_units) }
    it { should validate_presence_of(:step) }

    it { should validate_numericality_of(:step).allow_nil }
  end

  describe 'Callbacks' do

    describe 'get_options' do
    end

    describe 'set_options' do
    end

    describe 'get_labels' do
    end

    describe 'set_labels' do
    end

    describe 'set_unit_amount' do
    end

    describe 'strip_title_and_extra' do
    end
  end

  describe 'ClassMethods' do
  end

  describe 'InstanceMethods' do

    # Validations
    describe 'maximum_units_must_be_greater_than_minimum_units' do
    end

    describe 'default_value_must_be_between_minimum_and_maximum' do
    end

    describe 'default_value_must_be_an_option' do
    end

    describe 'options_and_labels_must_agree' do
    end
  end
end
