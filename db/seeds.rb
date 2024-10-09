require "faker"

me = "https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBd0ErQXc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--2d5e88acd264501b52d1a84625c82aeba643b99e/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b67d9ded4d28d0969fbb98b4c21b79257705a99a/20240805_234634.jpg"

# Destroy any db objects
Rental.destroy_all
Vehicle.destroy_all
User.destroy_all

users = []
vehicles = []
one_in_three = [true, false, false]

User.create!({
  first_name: "Paul",
  last_name: "Devanney",
  user_name: Faker::Internet.username(specifier: 8..12),
  email: "pauldevanney92@gmail.com",
  password: "devanney",
  image_url: me,
  address_1: Faker::Address.building_number,
  address_2: Faker::Address.street_name,
  town_or_city: Faker::Address.city,
  county: Faker::Address.state,
  postcode: Faker::Address.postcode,
  phone_number: Faker::PhoneNumber.phone_number,
  mobile_number: Faker::PhoneNumber.cell_phone,
})

10.times do |i|
  fname = Faker::Name.first_name
  lname = Faker::Name.last_name
  user = User.create({
    first_name: fname,
    last_name: lname,
    user_name: Faker::Internet.username(specifier: 8..12),
    email: Faker::Internet.email(name: "#{fname}.#{lname}"),
    password: Faker::Internet.password(min_length: 8),
    image_url: Faker::Avatar.image,
    address_1: Faker::Address.building_number,
    address_2: Faker::Address.street_name,
    town_or_city: Faker::Address.city,
    county: Faker::Address.state,
    postcode: Faker::Address.postcode,
    phone_number: Faker::PhoneNumber.phone_number,
    mobile_number: Faker::PhoneNumber.cell_phone,
  })
  if user.persisted?
    (0..3).to_a.sample.times do |j|
      v_make = Faker::Vehicle.make
      vehicle = Vehicle.new({
        make: v_make,
        model: Faker::Vehicle.model(make_of_model: v_make),
        year_of_manufacture: Faker::Vehicle.year,
        description: Faker::Vehicle.standard_specs,
        mot_certificate: "MOT: #{Faker::Lorem.paragraph(sentence_count: rand(3..5))}",
        tax_details: "TAX: #{Faker::Lorem.paragraph(sentence_count: rand(1..3))}",
        number_plate: Faker::Vehicle.singapore_license_plate,
        price_per_day: rand(50.00..250.00).round(2),
        colour: Faker::Color.color_name,
        location_of_vehicle: "#{Faker::Address.city} #{Faker::Address.postcode}",
        image_url: Faker::LoremFlickr.colorized_image(size: "500x250", search_terms: ["car", "van", "campervan"]),
      })
      vehicle.user = user
      vehicle.save!
      vehicles << vehicle
    end
    users << user if one_in_three.sample
  end
end

users.each do |customer|
  start_offset = rand(0..31)
  end_offset = rand(0..31)
  the_vehicle = vehicles.sample
  next if customer == the_vehicle.user
  Rental.create({
    user: customer,
    vehicle: the_vehicle,
    hire_start_date: Date.today + start_offset,
    hire_end_date: Date.today + (start_offset + end_offset),
    duration: end_offset,
    charge: rand(50.0..250.0).round(2),
  })
end
