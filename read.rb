require_relative 'post.rb'
require_relative 'link.rb'
require_relative 'task.rb'
require_relative 'memo.rb'

# id, limit, type

require 'optparse'
options = {}

OptionParser.new do |opt|
  opt.banner = "Usage read.rb [options]"

  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  opt.on('--type POST TYPE', 'какой тип постов показывать (по умолчанию - любой пост)') {|o| options[:type] = o}
  opt.on('--id POST ID', 'этот ключ выведет пост, соответствующий данному ключу') {|o| options[:id] = o}
  opt.on('--limit NUMBER', 'укажите значение, сколько постов вы хотите вывести') {|o| options[:limit] = o}

end.parse!

result = Post.finder(options[:limit], options[:type], options[:id])

if result.is_a? Post # result is object type Memo, Link or Task
  puts "НАЙДЕНА ЗАПИСЬ ТИПА #{result.class.name} С ID: #{options[:id]}"
  result.to_strings.each do |line|
    puts line
  end
else # puts result table width all posts
  result.each do |row|
    puts
    row.each do |elemet|
      print "|  #{elemet.to_s.delete("\\n\\r")[0..40]}"
    end
  end
end

puts
