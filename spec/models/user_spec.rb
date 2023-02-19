require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'when all attributes are valid and role is patient' do
      it 'is valid' do
        user = User.new(email: 'patient@example.com', password: 'password', name: "user", role: 'Patient')
        expect(user.valid?).to eq(true)
      end
    end

    context 'when all attributes are valid and role is doctor' do
      it 'is valid' do
        user = User.new(email: 'doctor@example.com', password: 'password', name: "user", role: 'Doctor')
        expect(user.valid?).to eq(true)
      end
    end

    context 'when name is not present' do
      it 'is invalid' do
        user = User.new(email: 'user@example.com', password: 'password', name: nil, role: 'Patient')
        expect(user.valid?).to eq(false)
        expect(user.errors[:name]).to include("can't be blank")
      end
    end

    context 'when name is too long' do
      it 'is invalid' do
        user = User.new(email: 'user@example.com', password: 'password', name: '123123123123123123123', role: 'Patient')
        expect(user.valid?).to eq(false)
        expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
      end
    end

    context "when role is not 'Patient' or 'Doctor'" do
      it 'is invalid' do
        user = User.new(email: 'user@example.com', password: 'password', name: "user", role: 'Developer')
        expect(user.valid?).to eq(false)
        expect(user.errors[:role]).to include("Role must be 'Patient' or 'Doctor'")
      end
    end

    context 'when email is not unique' do
      it 'is invalid' do
        User.create!(email: 'user@example.com', password: 'password', name: 'User', role: 'Patient')

        user = User.new(email: 'user@example.com', password: 'password', name: 'Another User', role: 'Doctor')
        expect(user.valid?).to eq(false)
        expect(user.errors[:email]).to include("has already been taken")
      end
    end
  end
end
