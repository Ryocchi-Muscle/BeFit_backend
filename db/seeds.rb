# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.first

frequencies = ['1', '2', '3', '4', '5', '6']
genders = ['male', 'female']

genders.each do |gender|
  frequencies.each do |frequency|
    12.times do |week|
      program = user.training_programs.create(
        title: "Week #{week + 1} Program - #{gender} - #{frequency}回/週",
        image: "/images/week_#{week + 1}.jpg",
        gender: gender,
        frequency: frequency,
        week: week + 1
      )

      program.training_menus.create([
       { body_part: "脚", exercise_name: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
       { body_part: "胸", exercise_name: "ベンチプレス", set_info: "10回3セット, インターバル3分", other: "" }
      ])
    end
  end
end
