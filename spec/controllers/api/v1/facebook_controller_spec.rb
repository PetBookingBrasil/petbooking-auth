require 'spec_helper'

RSpec.describe Api::V1::FacebookController, type: :controller do
  let(:user) {
    User.create(
      name: 'User',
      email: 'email@email.com',
      password: '123123',
      password_confirmation: '123123'
    )
  }
  let(:session) {
    Session.create(
      user_id: user.id,
      device: 0,
      application: 0,
      provider: 'facebook',
      provider_uuid: 0,
    )
  }

  describe '#auth' do
    context 'when valid' do

      before do
        post :auth, params: {
           session: {
             email: user.email,
             device: 0,
             application: 0,
             provider: 'facebook',
             provider_uuid: 0,
           }
        }
      end

      it 'returns a session' do
        expect(response.code).to eql("200")
      end
    end

    context 'when invalid' do
      it 'returns a 422 if params are not correct' do
        post :auth, params: {
           session: {
             email: user.email,
             device: 0,
             provider: 'facebook',
             provider_uuid: 0,
           }
        }

        expect(response.code).to eql("422")
      end

      it 'returns a 404 if user not found' do
        post :auth, params: {
           session: {
             email: 'not_registered@email.com',
             application: 0,
             device: 0,
             provider: 'facebook',
             provider_uuid: 0,
           }
        }

        expect(response.code).to eql("404")
      end

      it 'returns a 422 if provider not facebook' do
        post :auth, params: {
           session: {
             email: user.email,
             application: 0,
             device: 0,
             provider: 'google',
             provider_uuid: 0,
           }
        }

        expect(response.code).to eql("422")
      end
    end

  end

end
