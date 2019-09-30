require 'spec_helper'

RSpec.describe SessionController, type: :controller do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when is valid to create a session' do
      before do
        post :create, user: { email: user.email, password: user.password }
      end

      it { expect(response.code).to eql(:200) }
      it { expect(assign(@current_user).to be_truthy }
      it { expect(assign(session['warden.user.user.key'])).to be_truthy }
    end

    context 'when is invalid to create a session' do
      before do
        post :create, user: { email: user.email, password: '.' }
      end

      it { expect(response.code).to eql(:404) }
      it { expect(assign(@current_user).to be_falsey }
      it { expect(assign(session['warden.user.user.key'])).to be_falsey }
    end


  end

  describe '#create_by_facebook' do
    context 'when is valid to create a session' do
      before do
        post :create, user: { email: user.email }
      end

      it { expect(response.code).to eql(:200) }
      it { expect(assign(@current_user).to be_truthy }
    end

    context 'when is invalid to create a session' do
      before do
        post :create, user: { email: user.email }
      end

      it { expect(response.code).to eql(:404) }
      it { expect(assign(@current_user).to be_falsey }
    end
  end

end
