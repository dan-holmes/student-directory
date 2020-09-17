def input_students
  puts "Enter students one by one"
  puts "Enter an empty line when you're done"
  students = []
  while true do
    input = gets.chomp
    return students if input.empty?
    students << ({name: input, cohort: :november})
    puts "Now we have #{students.count} students"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
    list_number = index + 1
    puts "#{list_number}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
