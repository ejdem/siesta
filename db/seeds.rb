User.create!(name:  "admin",
             email: "admin2@siesta.com",
             password:              "admin1",
             password_confirmation: "admin1",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
User.create!(name:                  "tutor",
             email:                 "tutor@polsl.pl",
             password:              "tutor1",
             password_confirmation: "tutor1")

3.times do |n|
    name     = Faker::Name.name
    email    = "tutor-#{n+1}@polsl.pl"
    password = "password"
    User.create!(name:                  name,
                 email:                 email,
                 password:              password,
                 password_confirmation: password,
                 activated:             true,
                 activated_at:          Time.zone.now)
end

50.times do |n|
    name     = Faker::Name.name
    email    = "user-#{n+1}@student.polsl.pl"
    password = "password"
    User.create!(name:                  name,
                 email:                 email,
                 password:              password,
                 password_confirmation: password,
                 activated:             true,
                 activated_at:          Time.zone.now)
end

20.times do |n|
    _name = Faker::Lorem.words(3).join(" ")
    _desc = Faker::Lorem.sentences(2).join(". ")
    _ects = Random.new.rand(0..10)
    Subject.create!(name:        _name,
                    description: _desc,
                    ects:        _ects)
end