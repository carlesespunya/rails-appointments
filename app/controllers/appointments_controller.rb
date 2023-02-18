class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_patient, only: %i[new create]
  before_action :set_appointment, only: %i[show]
  before_action :set_is_doctor, only: %i[show index]

  def show
    render layout: false
  end

  def index
    if @is_doctor
      options = {doctor: current_user}
    else
      options = {patient: current_user}
    end

    @q = Appointment.ransack(params[:q])
    @pagy, @appointments = pagy(@q.result.where(options).order(created_at: :desc), items: 5)
  end

  def new
    if params[:doctor_id].blank?
      redirect_to users_path, alert: "Please select a doctor."
    else
      @doctor = User.find(params[:doctor_id])
      @appointment = Appointment.new
    end
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(patient: current_user))

    if @appointment.save
      redirect_to appointments_path, notice: "appointment was successfully created."
    else
      redirect_to new_appointment_path(doctor_id: appointment_params[:doctor_id]), alert: @appointment.errors.full_messages.join("<br>").html_safe
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_is_doctor
    @is_doctor = current_user.role == 'Doctor'
  end

  def appointment_params
    params.require(:appointment).permit(:front_pic, :right_pic, :left_pic, :appointment_date, :appointment_time, :doctor_id)
  end
end
