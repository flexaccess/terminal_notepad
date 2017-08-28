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

  def to_db_hash
    return super.merge(
        {
            'text' => @text.join('\n\r')
        }
    )
  end

  def load_data(data_hash) # {'created_at' => '2017.11.29'}
    super(data_hash)
    @text = data_hash['text'].split('\n\r')
  end # result this method is var @text @created_at @due_date @url
end