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

  def to_db_hash
    return super.merge(
        {
            'text' => @text,
            'url' => @url
        }
    )
  end

  def load_data(data_hash) # {'created_at' => '2017.11.29'}
    super(data_hash)
    @text = data_hash['text']
    @url = data_hash['url']
  end # result this method is var @text @created_at @due_date @url
end