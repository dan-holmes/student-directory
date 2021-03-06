require 'csv'

@students = []
@default_load_file = "students.csv"

def puts_center(text)
  page_width = 80
  puts text.center(page_width)
end

def input_students
  loop do
    puts "Enter a student's name:"
    puts "Enter an empty line when you're done"
    name = STDIN.gets.chomp
    break if name.empty?
    puts "Enter their country:"
    country = STDIN.gets.chomp
    puts "Enter their cohort (if you know it):"
    cohort = STDIN.gets.chomp
    student_details = [name,country,cohort]
    add_student(student_details)
    puts "Now we have #{@students.count} students."
  end
end

def print_header
  puts_center("The students of Villains Academy")
  puts_center("-------------")
end

def print_students
  return if @students.count == 0 # Do not try and print the list if it's empty
  cohorts = get_cohorts
  cohorts.each { |cohort|
      puts_center "#{cohort} cohort:"
      print_students_in(cohort)
    }
    puts ""
end

def print_students_in(cohort)
  @students.each { |student|
    if student[:cohort] == cohort
      puts_center("#{student[:name]} | #{student[:country]}")
    end
  }
end

def get_cohorts
  @students.map {|student| student[:cohort]}.uniq
end

def filter_by_letter(letter)
  filtered_students = []
  @students.each { |student|
    filtered_students << student if student[:name][0] == letter
  }
  filtered_students
end

def filter_less_than_12
  filtered_students = []
  @students.each { |student|
    filtered_students << student if student[:name].length < 12
  }
  filtered_students
end

def print_footer
  @students.count == 1 ? plural_modifier = "" : plural_modifier = "s"
  puts_center("Overall we have #{@students.count} great student#{plural_modifier}")
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit"
end

def show_students
  print_header
  print_students
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    handle_save_option
  when "4"
    handle_load_option
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students(filename = @default_load_file)
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:country], student[:cohort]]
    end
  end
  puts "Saved #{@students.count} to #{filename}"
end

def add_student(student_details)
  name, country, cohort = student_details
  cohort = "November" if cohort.nil?
  @students << {name: name, country: country, cohort: cohort.to_sym}
end

def load_students(filename = @default_load_file)
  CSV.foreach(filename, "r") do |line|
      add_student(line)
  end
  puts "Loaded #{@students.count} from #{filename}"
end

def get_load_file
  if !ARGV.first.nil?
    filename = ARGV.first
  else
    filename = @default_load_file
  end
end

def try_loading_from(filename)
  if File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def try_load_students
  filename = get_load_file
  try_loading_from(filename)
end

def handle_save_option
  puts "Enter save file:"
  filename = gets.chomp
  save_students(filename)
end

def handle_load_option
  puts "Enter load file:"
  filename = gets.chomp
  load_students(filename)
end

try_load_students
interactive_menu
