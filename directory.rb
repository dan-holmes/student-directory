@students = []

def puts_center(text)
  page_width = 80
  puts text.center(page_width)
end

def input_students
  puts "Enter students one by one, followed by their country of origin and cohort"
  puts "Enter an empty line when you're done"
  while true do
    input = STDIN.gets.delete("\n") # Modified from gets.chomp to satisfy excercise 10
    break if input.empty?
    name = input
    puts "Enter country:"
    country = STDIN.gets.chomp
    puts "Enter cohort:"
    cohort = STDIN.gets.chomp
    cohort = "November" if cohort.empty?
    cohort = cohort.to_sym
    @students << ({name: input, cohort: cohort, country: country})
    puts "Now we have #{@students.count} students"
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
    @students.each { |student|
      if student[:cohort] == cohort
        puts_center("#{student[:name]} | #{student[:country]}")
      end
    }
    puts ""
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
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
    save_students
  when "4"
    load_students
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

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:country], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, country, cohort = line.chomp.split(",")
    @students << {name: name, country: country, cohort: cohort.to_sym}
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
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

try_load_students
interactive_menu
