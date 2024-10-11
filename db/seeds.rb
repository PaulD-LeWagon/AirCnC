require "faker"

me = "https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBd0ErQXc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--2d5e88acd264501b52d1a84625c82aeba643b99e/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b67d9ded4d28d0969fbb98b4c21b79257705a99a/20240805_234634.jpg"
rehyan = "https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBNG8vQXc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--a1530a9964ce16af17cb666ed21808f9b7ce9baa/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--df4f7d63fe19fb30952f52eed6dffc392a97578c/IMG_3268.png"
jon = "https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBLzFKQXc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--f8872b71011e210ae17fc973906c1e365fa78db0/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--df4f7d63fe19fb30952f52eed6dffc392a97578c/MEZOOM.png"

# Destroy any db objects
Rental.destroy_all
Vehicle.destroy_all
User.destroy_all

users = [
  User.create!({
    first_name: "Paul",
    last_name: "Devanney",
    email: "pauldevanney92@gmail.com",
    password: "devanney",
    image_url: me,
    address: "#{Faker::Address.building_number}, #{Faker::Address.street_name}, #{Faker::Address.city}, #{Faker::Address.state}, #{Faker::Address.postcode}",
    phone_number: Faker::PhoneNumber.phone_number,
  }),
  User.create!({
    first_name: "Rehyan",
    last_name: "Rhoden",
    email: "rehyan92@gmail.com",
    password: "rehyan92",
    image_url: rehyan,
    address: "#{Faker::Address.building_number}, #{Faker::Address.street_name}, #{Faker::Address.city}, #{Faker::Address.state}, #{Faker::Address.postcode}",
    phone_number: Faker::PhoneNumber.phone_number,
  }),
  User.create!({
    first_name: "Jon",
    last_name: "Hollingsworth",
    email: "jondriveuk@gmail.com",
    password: "jondriveuk",
    image_url: jon,
    address: "#{Faker::Address.building_number}, #{Faker::Address.street_name}, #{Faker::Address.city}, #{Faker::Address.state}, #{Faker::Address.postcode}",
    phone_number: Faker::PhoneNumber.phone_number,
  }),
]

15.times do |j|
  # search_terms = ["lambretta", "car", "vw beetle", "campervan"].sample
  v_make = Faker::Vehicle.make
  v_model = Faker::Vehicle.model(make_of_model: v_make)
  search_terms = [v_make, v_model, "car"]
  vehicle = Vehicle.new({
    make: v_make,
    model: v_model,
    year: Faker::Vehicle.year,
    description: Faker::Lorem.paragraph(sentence_count: rand(10..20)),
    price_per_day: rand(10.25..50.95).round(2),
    colour: Faker::Color.color_name.capitalize,
    location: "#{Faker::Address.city} #{Faker::Address.postcode}",
    image_url: Faker::LoremFlickr.image(size: "500x250", search_terms: search_terms),
  })
  vehicle.user = users.sample
  vehicle.save!
end
