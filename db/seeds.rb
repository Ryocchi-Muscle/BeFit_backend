user = User.first

frequencies = ['1', '2', '3', '4', '5', '6']
genders = ['male', 'female']

genders.each do |gender|
  frequencies.each do |frequency|
    12.times do |week|
      program = user.training_programs.create(
        title: "Week #{week + 1} Program - #{gender} - #{frequency}回/週",
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
