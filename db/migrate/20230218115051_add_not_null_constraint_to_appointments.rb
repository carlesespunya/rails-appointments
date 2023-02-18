class AddNotNullConstraintToAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :appointments, :appointment_date, false
    change_column_null :appointments, :appointment_time, false
  end
end
