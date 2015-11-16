User.create!(name:                  "admin",
             email:                 "admin@siesta.com",
             password:              "admin1",
             password_confirmation: "admin1",
             admin:                 true,
             activated:             true,
             activated_at:          Time.zone.now)

10.times do |n|
    _name     = Faker::Name.name
    _email    = "tutor-#{n+1}@polsl.pl"
    _password = "password"
    User.create!(name:                  _name,
                 email:                 _email,
                 password:              _password,
                 password_confirmation: _password,
                 activated:             true,
                 activated_at:          Time.zone.now)
end

50.times do |n|
    _name     = Faker::Name.name
    _email    = "user-#{n+1}@student.polsl.pl"
    _password = "password"
    User.create!(name:                  _name,
                 email:                 _email,
                 password:              _password,
                 password_confirmation: _password,
                 activated:             true,
                 activated_at:          Time.zone.now)
end

20.times do |n|
    _name = Faker::Lorem.words(3).join(" ")
    _desc = Faker::Lorem.paragraph
    _ects = Random.new.rand(0..10)
    Subject.create!(name:        _name,
                    description: _desc,
                    ects:        _ects)
end

users = User.all
users.each do |user|
    10.times do
        _note1 = Random.new.rand(2..5)
        _note2 = Random.new.rand(2..5)
        _note  = (_note1+_note2)/2.0
        _s_id  = Random.new.rand(1..20)
        _a_id  = Random.new.rand(1..10)
        _aut   = User.find(_a_id)
        user.notes.create!(note:       _note,
                           subject_id: _s_id,
                           user_id:     user.id,
                           author:     _aut.name)
    end
end