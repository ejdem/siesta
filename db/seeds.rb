User.create!(name:  "admin",
             email: "admin@siesta.com",
             password:              "admin1",
             password_confirmation: "admin1",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
