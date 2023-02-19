class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User"
  belongs_to :patient, class_name: "User"

  has_one_attached :front_pic
  has_one_attached :right_pic
  has_one_attached :left_pic

  validates :doctor, :patient, :appointment_date, :appointment_time, presence: true
  validate :appointment_date_and_time_validations
  validate :doctor_availability
  validate :attachments_presence
  validate :doctor_role
  validate :patient_role

  private

  def appointment_date_and_time_validations
    if !appointment_date.is_a?(ActiveSupport::TimeWithZone) || !appointment_time.is_a?(ActiveSupport::TimeWithZone)
      errors.add(:appointment_date, "➡️ Appointment date and time must be dates")
    elsif appointment_date < Date.today
      errors.add(:appointment_date, "➡️ The Booking can't be in the past")
    end
  end

  def doctor_availability
    if Appointment.where(doctor_id: doctor_id, appointment_date: appointment_date, appointment_time: appointment_time).exists?
      errors.add(:appointment_time, "➡️ Already Booked, try another date or time")
    end
  end

  def attachments_presence
    if !front_pic.attached? || !right_pic.attached? || !left_pic.attached?
      errors.add(:base, "➡️ Please attach all required images")
    end
  end

  def doctor_role
    if doctor && doctor.role != "Doctor"
      errors.add(:doctor, "➡️ The doctor must have a role of 'Doctor'")
    end
  end

  def patient_role
    if patient && patient.role != "Patient"
      errors.add(:doctor, "➡️ The patient must have a role of 'Patient'")
    end
  end
end
