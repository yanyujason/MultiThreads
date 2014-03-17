require "thread"
puts "Synchronize Thread"

@data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
@mutex = Mutex.new

def print_data num
  @mutex.lock
  if @data.size > 0
    puts "print out #{@data.first()} and sleep #{num} seconds"
    @data = @data[1..-1]
    sleep num
  else
    puts "no more numbers and no sleep."
  end
  @mutex.unlock
end

thread_1 = Thread.new do
  20.times do
    print_data 1
    sleep 0.01
  end
end

thread_2 = Thread.new do
  20.times do
    print_data 3
    sleep 0.01
  end
end

thread_1.join
thread_2.join