Appointment.destroy_all
User.destroy_all

User.create!(
  name: "patient",
  email: "patient@mail.com",
  role: 'Patient',
  city: Faker::Address.city,
  password: "123123123"
)

User.create!(
  name: "doctor",
  email: "doctor@mail.com",
  role: 'Doctor',
  city: Faker::Address.city,
  password: "123123123"
)

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    role: 'Patient',
    city: Faker::Address.city,
    password: "123123123"
  )
end

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    role: 'Doctor',
    city: Faker::Address.city,
    password: "123123123"
  )
end
