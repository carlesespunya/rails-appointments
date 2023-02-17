User.destroy_all
Appointment.destroy_all

User.create!(
  name: "admin",
  email: "admin@mail.com",
  role: 'Patient',
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
