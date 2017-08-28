require_relative 'post.rb'
require_relative 'link.rb'
require_relative 'task.rb'
require_relative 'memo.rb'

puts "Hey! I'm your notepad! Version 2.0 (SQLite)"
puts "Choice a type:"

choices = Post.post_types.keys
choice = -1

until choice > 0 && choice <= choices.size do
  choices.each_with_index do |value, key|
    puts "\t#{key+1}. #{value}"
  end

  choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choices[(choice-1)])
entry.read_from_console
id = entry.save_to_db

puts "\n\rPOST IS DONE!"
puts "ID POST: #{id}"
 
