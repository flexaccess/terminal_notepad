require 'sqlite3'

class Post

  @@SQLITE_DB_FILE = 'notepad.sqlite'

  def self.post_types
    return {'Memo' => Memo, 'Link' => Link, 'Task' => Task}
  end

  def self.create(type)
    return post_types[type].new
  end

  def self.finder(limit, type, id)

    db = SQLite3::Database.open(@@SQLITE_DB_FILE)

    if !id.nil?
      db.results_as_hash = true
      result = db.execute("SELECT * FROM posts WHERE rowid = ?", id)
      result = result[0] if result.is_a? Array # pointless?
      db.close

      if result.nil?
        abort "Такой ID #{id} не найден"
      else # there is hash width data post
        post = create(result['type']) # there is OBJECT class 'type'
        post.load_data(result)
        return post
      end
      # return table width all post
    else
      db.results_as_hash = false
      query = "SELECT rowid, * FROM posts "
      query += "WHERE type = :type " if !type.nil?
      query += "ORDER BY rowid DESC "

      query += "LIMIT :limit " if !limit.nil?

      statement = db.prepare(query)
      statement.bind_param('type', type) if !type.nil?
      statement.bind_param('limit', limit) if !limit.nil?

      result = statement.execute!
      statement.close
      db.close

      return result
    end
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

  def save_to_db
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)
    db.results_as_hash = true

    db.execute(
        "INSERT INTO posts (" +
            to_db_hash.keys.join(',') +
            ") VALUES (" +
            ('?,'*to_db_hash.keys.size).chomp(',') +
            ")", to_db_hash.values
    )

    insert_row_id = db.last_insert_row_id
    db.close
    return insert_row_id
  end

  def to_db_hash
    {
        'type' => self.class.name,
        'created_at' => @created_at.to_s
    }
  end

  def load_data(data_hash) # {'created_at' => '2017.11.29'}
    @created_at = Date.parse(data_hash['created_at'])
  end

  def file_path
    current_path = File.dirname(__FILE__)
    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H:%M:%S.txt")

    return current_path + "/data/" + file_name
  end
end