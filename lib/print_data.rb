require 'thread'
require '../lib/semaphore.rb'

@max = 2
@thread_number = 5

mutex = Mutex.new
semaphores = Semaphore.new(@max)

data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

@thread_number.times do |x|
  thread = Thread.new do
    while (data.length > 0) do
      semaphores.synchronize do
        mutex.synchronize do
          num = data[0]
          data = data[1..-1]
          print_data x, num
        end
        sleep 1
      end
      puts "Thread #{x} ended\n"
    end
  end
end


def print_data(thread, num)
  puts "Thread #{thread} printed out number #{num}\n"
end

sleep 20