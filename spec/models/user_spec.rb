require 'rails_helper'

describe User, type: :model do

  describe 'relations' do
    it { is_expected.to have_many(:sessions) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:search_range).is_greater_than_or_equal_to(5) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2) }
    it { is_expected.to validate_presence_of(:source) }

    context 'when zipcode is required' do
      before { allow(subject).to receive(:must_require_zipcode) { true } }
      it { is_expected.to validate_presence_of(:zipcode) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:state) }
      it { is_expected.to validate_presence_of(:street) }
      it { is_expected.to validate_presence_of(:street_number) }
      it { is_expected.to validate_presence_of(:neighborhood) }
    end

    context 'when password is required' do
      before { allow(subject).to receive('password_required?') { true } }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'when phone is required' do
      before { allow(subject).to receive('phone_required?') { true } }
      it { is_expected.to validate_presence_of(:phone) }
    end

    context 'when email is required' do
      before { allow(subject).to receive('email_required?') { true } }
      it { is_expected.to validate_presence_of(:email) }
    end

    context 'when password is required' do
      before { allow(subject).to receive('password_required?') { true } }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'when cpf is required' do
      before { allow(subject).to receive('must_require_cpf') { true } }
      it { is_expected.to validate_presence_of(:cpf) }
    end

    context 'when there is no phone value' do
      before { subject.update(phone: nil) }
      it { is_expected.to validate_presence_of(:landline) }
    end

    context 'when there is a phone value' do
      before { allow_any_instance_of(User).to receive(:should_validate_landline?).and_return(false) }
      it { is_expected.not_to validate_presence_of(:landline) }
    end
  end
end
