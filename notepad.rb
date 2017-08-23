require_relative 'post.rb'
require_relative 'link.rb'
require_relative 'task.rb'
require_relative 'memo.rb'

puts "Hey! I'm your notepad!"
puts "Choice a type:"

choices = Post.post_types
choice = -1

until choice > 0 && choice <= choice.size do
  choices.each_with_index do |value, key|
    puts "\t#{key+1}. #{value}"
  end

  choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choice-1).new
entry.read_from_console
entry.save

puts "\n\rPOST IS DONE!"