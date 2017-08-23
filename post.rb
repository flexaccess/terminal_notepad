class Post

  def self.post_types
    return [Memo, Link, Task]
  end

  def self.create(type_index)
    return post_types[type_index]
  end

  def initialize
    @text = nil
    @created_at = Time.now
  end

  def read_from_console
    # todo
  end

  def to_strings
    # todo
  end

  def save
    file = File.new(file_path, 'w:UTF-8')
    for item in to_strings do
      file.puts item
    end
    file.close
  end

  def file_path
    current_path = File.dirname(__FILE__)
    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H:%M:%S.txt")

    return current_path + "/data/" + file_name
  end
end