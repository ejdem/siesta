User.create!(name:                  "admin",
             email:                 "admin@siesta.com",
             password:              "admin1",
             password_confirmation: "admin1",
             admin:                 true,
             activated:             true,
             activated_at:          Time.zone.now)
puts "seeds 1 done!"
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
puts "seeds 2 done!"
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
puts "seeds 3 done!"
20.times do |n|
    n = Faker::Lorem.words(3).join(" ")
    d = Faker::Lorem.paragraph
    e = Random.new.rand(0..10)
    Subject.create!(name:        n,
                    description: d,
                    ects:        e)
end
puts "seeds 4 done!"
users = User.all
users.drop(12).each do |u|
    10.times do
        n1 = Random.new.rand(1..5)
        n2 = Random.new.rand(1..5)
        n  = (n1+n2)/2.0
        s  = Random.new.rand(0..20)
        a  = Random.new.rand(2..10)
        at = User.find(a)
        u.notes.create!(note:       n,
                           subject_id: s,
                           user_id:    u.id,
                           author:     at.name)
    end
end
puts "seeds 5 done!"
users.drop(1).each do |user|
   10.times do |n|
       n+=1
       user.active_participations.create!(subject_id: n)
   end
end
puts "seeds 6 done!"

subjects = Subject.all
subjects.each do |s|
    posts = Random.new.rand(1..4)
    posts.times do
        t  = Faker::Lorem.words(3).join(" ")
        c  = Faker::Lorem.paragraph
        u = Random.new.rand(2..10)
        s.microposts.create!(title:   t,
                             content: c,
                             user_id: u)
    end
end
puts "seeds 7 done!"