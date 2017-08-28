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

  def to_db_hash

    return super.merge(
                    {
                        'text' => @text,
                        'due_date' => @due_date.to_s
                    }
    )
  end

  def load_data(data_hash) # {'created_at' => '2017.11.29'}
    super(data_hash)
    @text = data_hash['text']
    @due_date = Date.parse(data_hash['due_date'])
  end # result this method is var @text @created_at @due_date @url
end