class Task < Post
  def initialize
    super # pull to parent

    @due_date = Time.now
  end

  def read_from_console

  end
  def to_strings

  end
end