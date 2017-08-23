class Memo < Post

  def read_from_console
    puts "Enter the text as string. Finally write \"end\""
    @text = []
    line = nil

    while line != "end" && line != "End" do
      line = STDIN.gets.chomp
      @text << line
    end
    @text.pop
  end

  def to_strings
    time_string = "\n\r========================\n\rCreated at: #{@created_at.strftime('%Y.%m.%d')}\n\r========================"
    return @text << time_string
  end
end