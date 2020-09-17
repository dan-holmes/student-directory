def puts_center(text)
  page_width = 80
  puts text.center(page_width)
end

def input_students
  puts "Enter students one by one, followed by their country of origin and cohort"
  puts "Enter an empty line when you're done"
  students = []
  while true do
    input = gets.delete("\n") # Modified from gets.chomp to satisfy excercise 10
    return students if input.empty?
    name = input
    puts "Enter country:"
    country = gets.chomp
    puts "Enter cohort:"
    cohort = gets.chomp
    cohort = "November" if cohort.empty?
    cohort = cohort.to_sym
    students << ({name: input, cohort: cohort, country: country})
    puts "Now we have #{students.count} students"
  end
end

def print_header
  puts_center("The students of Villains Academy")
  puts_center("-------------")
end

def print(students)
  cohorts = get_cohorts(students)
  cohorts.each { |cohort|
    puts_center "#{cohort} cohort:"
    students.each { |student|
      if student[:cohort] == cohort
        puts_center("#{student[:name]} from #{student[:country]}")
      end
    }
  }
end

def get_cohorts(students)
  return students.map {|student| student[:cohort]}.uniq
end

def filter_by_letter(students, letter)
  filtered_students = []
  students.each { |student|
    filtered_students << student if student[:name][0] == letter
  }
  filtered_students
end

def filter_less_than_12(students)
  filtered_students = []
  students.each { |student|
    filtered_students << student if student[:name].length < 12
  }
  filtered_students
end

def print_footer(students)
  puts ""
  students.count > 1 ? plural_modifier = "s" : plural_modifier = ""
  puts_center("Overall we have #{students.count} great student#{plural_modifier}")
end

students = input_students
print_header
print(students)
print_footer(students)
