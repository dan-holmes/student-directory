def puts_center(text)
  page_width = 80
  puts text.center(page_width)
end

def input_students
  puts "Enter students one by one, followed by their country of origin"
  puts "Enter an empty line when you're done"
  students = []
  while true do
    input = gets.chomp
    return students if input.empty?
    name = input
    puts "Enter country:"
    country = gets.chomp
    students << ({name: input, cohort: :november, country: country})
    puts "Now we have #{students.count} students"
  end
end

def print_header
  puts_center("The students of Villains Academy")
  puts_center("-------------")
end

def print(students)
  students.each_with_index do |student, index|
    list_number = index + 1
    puts_center("#{list_number}. #{student[:name]} from #{student[:country]} (#{student[:cohort]} cohort)")
  end
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
  puts_center("Overall we have #{students.count} great students")
end

students = input_students
print_header
print(filter_less_than_12(filter_by_letter(students,'D')))
print_footer(students)
