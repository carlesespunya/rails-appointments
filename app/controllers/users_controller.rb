class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_patient, only: [:index]

  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result.where(role: 'Doctor').order(created_at: :desc), items: 5)
  end

  def show
    @user = User.find(params[:id])

    render layout: false
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to current_user, notice: "Account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Appointment.where(patient_id: current_user.id).or(Appointment.where(doctor_id: current_user.id)).destroy_all
    current_user.destroy

    redirect_to root_path, notice: "Account was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :city, :name, :email, :password, :password_confirmation)
  end
end
