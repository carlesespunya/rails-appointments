class User < ApplicationRecord
  ROLES = %w[Patient Doctor].freeze

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_one_attached :avatar
  has_many :articles, dependent: :destroy
  has_many :appointments

  validates :role, inclusion: { in: ROLES, message: "Role must be 'Patient' or 'Doctor'" }
  validates :name, presence: true, length: { maximum: 50 }

  def name
    @name ||= self[:name].presence || email.split("@").first
  end

  protected

  def password_required?
    new_record? || password.present?
  end
end
