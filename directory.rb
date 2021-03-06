require 'csv'
@students = [] # an empty array accessible to all methods

def interactive_menu
  while true do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the student list to file students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" 
  return
end

def process(selection)
  case selection
    when "1"
      input_students
      puts "Your inputs are successful"
    when "2"
      show_students
    when"3"
      save_students
      puts "Successfully saved students to the file, enter 4 to load the updated list"
    when "4"
      puts "Please enter the name of a file you want to load students from"
      filename = STDIN.gets.chomp
      load_students(filename)
      puts "Updated list of students loaded from the file, enter 2 to see the list"
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def try_load_students
  filename = ARGV.first 
  if filename.nil? 
    load_students
    puts "Loaded #{@students.count} from students.csv"
  else
    check_file_exists(filename) 
  end
end

def check_file_exists(filename)
  if File.exists?(filename) 
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
      # if it doesn't exist
      puts "Sorry, #{filename} doesn't exist."
      exit # quit the program
  end
end


def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    CSV.foreach(file) do |line|
      name = line[0]
      cohort = line[1]
      add_students(name, cohort)
    end
  end
end

def add_students(name, cohort)
  return if cohort.nil?
  @students << {name: name, cohort: cohort.to_sym}

end
	

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
  # add the student hash to the array
  add_students(name, "november")
  # @students << {name: name, cohort: :november}
  puts "Now we have #{@students.count} students"
  # get another name from the user
  name = STDIN.gets.chomp
  end
  # return the array of students
  return @students
end

def save_students
  puts "Please enter the name of the file you want to save your list"
  filename = STDIN.gets.chomp
  # open the file for writing
  File.open(filename, "w") do |file|
    # iterate over the array of students
    @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
    end
  end
end


def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print_students_list
    @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end


def print_footer
  puts "Overall, we have #{@students.count} great students"
end

try_load_students
interactive_menu



