require 'thread'
require '../lib/semaphore.rb'

@max = 2
@thread_number = 5

mutex = Mutex.new
semaphores = Semaphore.new(@max)

data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

@thread_number.times do |x|
  thread = Thread.new do
    loop do
      semaphores.synchronize do
        num = 0
        mutex.synchronize do
          num = data[0]
          data = data[1..-1]
        end
        print_data x, num if num != nil
      end
    end
  end
end


def print_data(thread, num)
  sleep 1
  puts "Thread #{thread} printed out number #{num}\n"
end

sleep 10
