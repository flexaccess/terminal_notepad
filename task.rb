require 'date'
class Task < Post
  def initialize
    super # pull to parent

    @due_date = Time.now
  end

  def read_from_console
    puts "What you need to do?"
    @text = STDIN.gets.chomp

    puts "When to do that? [24.08.2017]"
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    deadline = "To make it to: #{@due_date}"
    time_string = "\n\r========================\n\rCreated at: #{@created_at.strftime('%Y.%m.%d')}\n\r========================"

    return ["Task: " + @text, deadline, time_string]
  end
end