@students = []

def replace_chmp(string)
  return string.rstrip
end

def order_students
  @students.sort_by! { |hsh| hsh[:cohort] }
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  @students = []
  cohorts = ["January","February","March","April","May","June","July","August","September","October","November","December"]
  name = STDIN.gets
  name = replace_chmp(name)
  while !name.empty? do
    puts "Please enter the students hobbies"
    hobbies = STDIN.gets
    hobbies = replace_chmp(hobbies)
    puts "Please enter a cohort"
    cohort = STDIN.gets
    cohort = replace_chmp(cohort)

    if !cohorts.include?(cohort.downcase.capitalize)
      cohort = "November"
    end

    add_name_and_cohort(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets
    name = replace_chmp(name)
  end
  order_students
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student [:cohort]]
    csv_line = student_data.join(",")
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    add_name_and_cohort(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def specific_letter
  while true
    puts "Which letter do you want the name filter to start with?"
    filter = STDIN.gets.chomp
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

def print_students_list
  filter = specific_letter
  count = @students.count
  if count < 1 || nil
    puts "Please add a student"
    input_students
  end
  i = 0
  while i < count
    if @students[i][:name].start_with?(filter) && @students[i][:name].length <= 12
      puts "#{i + 1}: Name: #{@students[i][:name]} (Cohort: #{@students[i][:cohort]}) (Hobbies: #{@students[i][:hobbies]})".center(80)
    end
    i+=1
  end
end

def print_footer
  student_count = @students.count
  if student_count == 1
    puts "Overall, we have #{student_count} great student."
  else
    puts "Overall, we have #{student_count} great students."
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def add_name_and_cohort(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def process(selection)
  case selection
  when "1"
    students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

try_load_students
interactive_menu
