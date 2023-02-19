require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:doctor) { User.create(name: 'Dr. John', email: 'doctor@example.com', password: 'password', role: 'Doctor') }
  let(:patient) { User.create(name: 'Jane', email: 'patient@example.com', password: 'password', role: 'Patient') }

  describe 'validations' do
    context 'when all attributes are valid' do
      it 'is valid' do
        appointment = Appointment.new(doctor: doctor, patient: patient, appointment_date: Date.tomorrow, appointment_time: Time.now, front_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), right_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), left_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')))
        expect(appointment.valid?).to be true
      end
    end

    context 'when doctor is not present' do
      it 'is not valid' do
        appointment = Appointment.new(patient: patient, appointment_date: Date.tomorrow, appointment_time: Time.now, front_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), right_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), left_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')))
        expect(appointment.valid?).to be false
      end
    end

    context 'when patient is not present' do
      it 'is not valid' do
        appointment = Appointment.new(doctor: doctor, appointment_date: Date.tomorrow, appointment_time: Time.now, front_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), right_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), left_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')))
        expect(appointment.valid?).to be false
      end
    end

    context 'when doctor is not doctor' do
      it 'is not valid' do
        appointment = Appointment.new(doctor: patient, patient: patient, appointment_date: Date.tomorrow, appointment_time: Time.now, front_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), right_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), left_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')))
        expect(appointment.valid?).to be false
      end
    end

    context 'when patient is not patient' do
      it 'is not valid' do
        appointment = Appointment.new(doctor: doctor, patient: doctor, appointment_date: Date.tomorrow, appointment_time: Time.now, front_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), right_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), left_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')))
        expect(appointment.valid?).to be false
      end
    end

    context 'when appointment date is in the past' do
      it 'is not valid' do
        appointment = Appointment.new(doctor: doctor, patient: patient, appointment_date: Date.yesterday, appointment_time: Time.now, front_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), right_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), left_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')))
        expect(appointment.valid?).to be false
      end
    end

    context 'when appointment date and time are not valid' do
      it 'is not valid' do
        appointment = Appointment.new(doctor: doctor, patient: patient, appointment_date: 'invalid', appointment_time: 'invalid', front_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), right_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')), left_pic: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png')))
        expect(appointment.valid?).to be false
      end
    end

    context 'when the doctor is not available' do
      let(:appointment_date) { Date.tomorrow }
      let(:appointment_time) { Time.parse('09:00:00') }

      before do
        Appointment.create(doctor: doctor, patient: patient, appointment_date: appointment_date, appointment_time: appointment_time)
      end

      it 'is not valid' do
        appointment = Appointment.new(doctor: doctor, patient: patient, appointment_date: appointment_date, appointment_time: appointment_time)
        expect(appointment.valid?).to be false
      end
    end

    context 'when attachments are missing' do
      it 'is not valid' do
        appointment = Appointment.new(doctor: doctor, patient: patient, appointment_date: Date.tomorrow, appointment_time: Time.now)
        expect(appointment.valid?).to be false
      end
    end
  end
end
