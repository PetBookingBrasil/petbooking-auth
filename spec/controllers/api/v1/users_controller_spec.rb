require 'spec_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  @@user_attributes = {
    source: "web",
    device: "crhome xpto",
    provider: "petbooking",
    name: "Douglas Andre",
    email: "douglas@petbooking.com.br",
    password: "123123123",
    birthday: "1989-10-27",
    city: "Curitiba",
    state: "PR",
    cpf: "06397826988",
    phone: "41987368933",
    gender: "male",
    nickname: "Doug",
    search_range: 5,
    zipcode: "80010100",
    street: "Av. Cândido de Abreu",
    street_number: "400",
    neighborhood: "Centro Cívico",
    skype: "dougmoura",
    complement: "Ap 3002" }

  describe '#create' do
    context 'when the user was created successfully' do
      let(:response) { post(:create) }
      it { expect(response).to have_http_status(:created) }

      @@user_attributes.each do |key, value|
        it "returns the created user with #{key} and #{value}" do
          expect(response.body[:user][key]).to eq(value)
        end
      end

      it 'returns a JWT token for the next user requests' do
        expect(response).to eq(@@user_attributes)
      end
    end

    context 'when the user was not created successfully' do
      subject { post :create }

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
