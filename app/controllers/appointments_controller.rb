class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_patient, only: %i[new, create]


  def index
    @appointments = Appointment.all
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

  def destroy
    @appointment.destroy

    redirect_to appointments_path, notice: "appointment was successfully destroyed."
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :appointment_time, :doctor_id)
  end
end
