class Link < Post
  def initialize
    super # pull to parent

    @url = ''
  end

  def read_from_console
    puts "Enter URL:"
    @url = STDIN.gets.chomp

    puts "Enter description:"
    @text = STDIN.gets.chomp
  end

  def to_strings
    time_string = "\n\r========================\n\rCreated at: #{@created_at.strftime('%Y.%m.%d')}\n\r========================"
    return ["Link: #{@url}", "Description: #{@text}", time_string]
  end
end