require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'Requires a name' do
      user = User.new(email: 'user@example.com', password: 'password', name: nil, role: 'Patient')
      expect(user.valid?).to eq(false)
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'Validates name lenght' do
      user = User.new(email: 'user@example.com', password: 'password', name: '123123123123123123123', role: 'Patient')
      expect(user.valid?).to eq(false)
      expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "Role must be 'Patient' or 'Doctor'" do
      user = User.new(email: 'user@example.com', password: 'password', name: "user", role: 'Developer')
      expect(user.valid?).to eq(false)
      expect(user.errors[:role]).to include("Role must be 'Patient' or 'Doctor'")
    end

    it 'Requires a unique email address' do
      User.create!(email: 'user@example.com', password: 'password', name: 'User', role: 'Patient')
      user = User.new(email: 'user@example.com', password: 'password', name: 'Another User', role: 'Doctor')
      expect(user.valid?).to eq(false)
      expect(user.errors[:email]).to include("has already been taken")
    end
  end
end
