require 'spec_helper'

describe Session, type: :model do

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
  end
end
