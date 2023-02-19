require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a name' do
      user = User.new(email: 'user@example.com', password: 'password', name: nil, role: 'Patient')
      expect(user.valid?).to eq(false)
      expect(user.errors[:name]).to include("can't be blank")
    end
  end
end
