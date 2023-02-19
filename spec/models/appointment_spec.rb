require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'validations' do
    it 'requires a doctor' do
      appointment = Appointment.new(doctor: nil, patient: nil, appointment_date: nil, appointment_time: nil)
      expect(appointment.valid?).to eq(false)
    end
  end
end
