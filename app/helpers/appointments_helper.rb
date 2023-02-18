module AppointmentsHelper
  def appointment_date(appointment)
    "#{format_date(appointment.appointment_date)}"
  end

  def format_date(date)
    date.strftime("%B %d, %Y")
  end

  def appointment_time(appointment)
    "#{format_time(appointment.appointment_time)}"
  end

  def format_time(time)
    time.strftime("%I:%M %p")
  end

  def appointment_pic(pic)
    if pic.attached?
      image_tag pic, class: "h-40"
    end
  end
end
