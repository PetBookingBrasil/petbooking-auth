require 'spec_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  USER_FIELDS = %w(source device provider name email 
    password birthday city state cpf phone gender nickname 
    search_range zipcode street street_number neighborhood skype complement)

  describe '#create' do
    context 'when the user was created successfully' do
      let(:user) { build(:user) }
      let(:response) do
        post(:create, params: {
                        data: {
                          attributes: user.attributes.merge({
                            password: '123123123',
                            device: 'Chrome XPTO',
                            application: 'petbooking'
                          })
                        }
                      } )
      end
      
      it { expect(response).to have_http_status(:created) }

      USER_FIELDS.each do |user_field|
        it "returns the created user with the correct #{user_field}" do
          expect(response.body['user'][user_field]).to eq(user.send(user_field))
        end
      end

      it 'returns a JWT token for the user', first: true do
        byebug
        expect(response.body['user']['token']).to_not be_nil
      end
    end

    context 'when the user was not created successfully' do
      subject { post :create, user.attributes.except(:name) }

      context 'when there is a problem with the params' do
        it { expect(response).to have_http_status(:unprocessable_entity) }

        it 'returns a JSON with the error' do
          expect(response.body['errors']['name']).to eq('Não pode ser vazio')
        end
      end

      context 'when ocurred a server error' do
        it { expect(response).to have_http_status(:internal_server_error) }

        it 'returns an internal server error on JSON' do
          expect(response).to eq(user_attributes)
        end
      end
    end
  end


  context 'signed user requests' do
  #   let(:current_user) { create(:user) }

  #   before do
  #     signin(current_user)
  #   end

    describe '#update' do
      let(:user_attributes) {  }
      let(:response) { put :update }

      context 'when valid' do
        it { expect(response).to have_http_status(:success) }

        it 'returns the updated user on JSON response' do
          expect(response).to eq(user_attributes)
        end
      end

      context 'when invalid' do
        context 'when there is a problem with the params' do
          it { expect(response).to have_http_status(:unprocessable_entity) }

          it 'returns a JSON with the error' do
            expect(response).to eq(user_attributes)
          end
        end

        context 'when ocurred a server error' do
          it { expect(response).to have_http_status(:internal_server_error) }

          it 'returns an internal server error on JSON' do
            expect(response).to eq(user_attributes)
          end
        end
      end
    end

    describe '#show' do
      context 'when valid' do
        it { expect(response).to have_http_status(:success) }

        it 'returns the complete user on JSON response' do
          expect(response).to eq(user_attributes)
        end
      end

      context 'when invalid' do
        context 'when user does not exists' do
          it { expect(response).to have_http_status(:not_found) }

          it 'returns a JSON with the error' do
            expect(response).to eq(user_attributes)
          end
        end

        context 'when ocurred a server error' do
          it { expect(response).to have_http_status(:internal_server_error) }

          it 'returns an internal server error on JSON' do
            expect(response).to eq(user_attributes)
          end
        end
      end
    end
  end
end
