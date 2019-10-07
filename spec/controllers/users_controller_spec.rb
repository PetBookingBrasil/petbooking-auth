require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:current_user) { create(:user) }

  before do
    sign_in(current_user)
  end

  describe '#registration_edit' do
    before do
      get :registration_edit
    end

    it { expect(assigns(:current_user)).to be_present }
  end

  describe '#change_password' do
    before do
      get :senha
    end

    it { expect(assigns(:current_user)).to be_present }
    it { expect(response.status).to eq 200 }
  end

  describe '#update' do
    before do
      old_name = current_user.name
    end

    context 'when is valid to update' do
      it { expect{ put :update, params: { user: { name: 'spec-test'} } }.to change{ current_user.reload.name }.from(old_name).to('spec-test') }
    end

    context 'when is invalid to update' do
      it { expect{ put :update, params: { user: { CPF: '0'} } }.to_not change{ current_user.reload.cpf.number } }
    end
  end

  describe '#update_password' do
    context 'when is valid to update' do
      before do
        current_user.update(password: '123123123')
      end

      it {
        expect{ put :update_password, params: {
            user: {
              current_password: '123123123',
              password: 'newpasswordtest',
              password_confirmation: 'newpasswordtest'
            }
          }, xhr: true }.to change{ current_user.reload.encrypted_password }
        }
    end

    context 'when is invalid to update' do
      context 'when current password is incorrect' do
        before do
          current_user.update(password: '123123123')
        end

        it {
          expect{ put :update_password, params: {
              user: {
                current_password: '111111111',
                password: 'newpasswordtest',
                password_confirmation: 'newpasswordtest'
              }
            }, xhr: true }.to_not change{ current_user.reload.encrypted_password }
          }
      end

      context 'when new password is invalid' do
        before do
          current_user.update(password: '123123123')
        end

        it {
          expect{ put :update_password, params: {
              user: {
                current_password: '123123123',
                password: '',
                password_confirmation: ''
              }
            }, xhr: true }.to_not change{ current_user.reload.encrypted_password }
          }
      end

      context 'when password confirmation does not match' do
        before do
          current_user.update(password: '123123123')
        end

        it {
          expect{ put :update_password, params: {
              user: {
                current_password: '123123123',
                password: 'newpasswordtest',
                password_confirmation: 'newpasswordtes'
              }
            }, xhr: true }.to_not change{ current_user.reload.encrypted_password }
          }
      end
    end
  end

  describe '#delete' do
    before do
      delete :delete
    end

    it { expect{ User.find(current_user.id) }.to raise_exception(ActiveRecord::RecordNotFound) }
  end
end
