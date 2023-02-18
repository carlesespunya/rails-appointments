class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_patient, only: %i[new, create]


  def index
    @appointments = Appointment.all
  end

  def new
    @doctor = User.find(params[:user_id])
    @appointment = Appointment.new
    render layout: false
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(patient: current_user))

    if @appointment.save
      redirect_to appointments_path, notice: "appointment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy

    redirect_to appointments_path, notice: "appointment was successfully destroyed."
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :doctor_id)
  end
end
