class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User"
  belongs_to :patient, class_name: "User"

  has_one_attached :front_pic
  has_one_attached :right_pic
  has_one_attached :left_pic

  validates :doctor, :patient, :appointment_date, :appointment_time, presence: true
  validate :appointment_date_cannot_be_in_the_past
  validate :doctor_availability
  validate :attachments_presence

  private

  def appointment_date_cannot_be_in_the_past
    if appointment_date < Date.today
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
end
