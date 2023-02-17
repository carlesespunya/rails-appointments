class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User"
  belongs_to :patient, class_name: "User"

  has_one_attached :frontPic
  has_one_attached :rightPic
  has_one_attached :leftPic

  validates :doctor, :patient, :appointment_date, presence: true
end
