def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  # pattern = "/^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$/"
  name = gets.chomp
  
  
def validate_name(name)
  pattern = "^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$"
  if name.match?(pattern)
     return true
  else
    return false
  end
end
  
  while !name.empty?  do
    # add the student hash to the array
    flag = validate_name(name)
    while flag == false do
      puts "Please check your name again"
      name = gets.chomp
      flag = validate_name(name)
    end
    cohort = validate_cohort
    students << {name: name, cohort: cohort.to_sym}
    puts "Now we have #{students.count} students".center(30)
    # get another name from the user
    puts "Please enter your name"
    name = gets.chomp
  end
  # return the array of students
  return students
end
  
  def validate_cohort
    year = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    puts "Please enter your cohort"
    cohort = gets.chomp
    if cohort.empty? 
      cohort = "november"
    end
    while !year.include?(cohort.downcase) do
      puts "Invalid Input"
      cohort = gets.chomp
    end
    return cohort
  end
  # while the name is not empty, repeat this code
  
def print_header
  puts "The students of Villains Academy".center(60)
  puts "-------------".center(60)
end

def print(students)
  i = 0
  while i < students.length do
      puts "#{students[i][:name]} cohort #{students[i][:cohort]}".center(60)
      i = i + 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(60)
end

students = input_students
#nothing happens until we call the methods
print_header
print(students)
print_footer(students)
