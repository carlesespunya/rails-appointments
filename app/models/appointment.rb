class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User"
  belongs_to :patient, class_name: "User"

  has_one_attached :frontPic
  has_one_attached :rightPic
  has_one_attached :leftPic

  validates :doctor, :patient, :appointment_date, :appointment_time, presence: true
  validate :appointment_date_cannot_be_in_the_past
  validate :doctor_availability

  private

  def appointment_date_cannot_be_in_the_past
    if appointment_date < Date.today
      errors.add(:appointment_date, "can't be in the past")
    end
  end

  def doctor_availability
    if Appointment.where(doctor_id: doctor_id, appointment_date: appointment_date, appointment_time: appointment_time).exists?
      errors.add(:appointment_time, "Already booked")
    end
  end
end
