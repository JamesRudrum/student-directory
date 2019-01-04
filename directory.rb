def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def specific_letter
  while true
    puts "Which letter do you want the name filter to start with?"
    filter = gets.chomp
    if filter.length == 1
      break
    else puts "Enter just one letter"
    end
  end
  filter
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  filter = specific_letter
  students.each_with_index do |student, index|
    if student[:name].start_with?(filter)
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
students = input_students
print_header
print(students)
print_footer(students)
