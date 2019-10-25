require 'spec_helper'
require './lib/api_constraints'

describe ApiConstraints do
  let(:api_v1) { ApiConstraints.new(version: 1) }
  let(:api_v2) { ApiConstraints.new(version: 2, default: true) }

  describe 'matches?' do
    context "when the version matches the 'Accept' header" do
      it 'returns true' do
        request = double(host: 'auth.petbooking.dev',
                         headers: { 'Accept' => 'application/vnd.petbooking.v1' })
        expect(api_v1.matches?(request)).to be_truthy
      end

      it "returns the default version when 'default' option is specified" do
        request = double(host: 'auth.petbooking.dev')
        expect(api_v2.matches?(request)).to be_truthy
      end
    end
  end
end