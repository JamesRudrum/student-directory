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
  count = students.count
  i = 0
  while i < count
    if students[i][:name].start_with?(filter) && students[i][:name].length <= 12
      puts "#{i + 1}: Name: #{students[i][:name]} (Cohort: #{students[i][:cohort]})"
    end
    i+=1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
students = input_students
print_header
print(students)
print_footer(students)
