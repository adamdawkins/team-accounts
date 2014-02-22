# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create at least one user to start with
User.create({
  email: "adamdawkins@gmail.com",
  password:"password",
  password_confirmation: "password"
})

categories = ["training equipment", "kit", "health and safety", "administrative costs", "registration fees", "grants", "player registration", "other"]

categories.each {|category_name| Category.create({name: category_name}) }

squads = ["Cadet Flag", "Junior Flag", "Youth Contact", "Junior Contact"]

squads.each {|squad_name| Squad.create({name: squad_name}) }
