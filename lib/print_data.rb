require 'thread'
require '../lib/semaphore.rb'

@max = 2
@thread_number = 5

mutex = Mutex.new
semaphores = Semaphore.new(@max)

queue = Queue.new
#(1..15).each do |i|
#  queue.push i
#end

threads =[]

@thread_number.times do |x|
  threads << Thread.new do
    loop do
      semaphores.synchronize do
        num = 0
        mutex.synchronize do
          num = queue.pop unless queue.empty?
        end
        if num != 0
          print_data x, num
        else
          Thread.stop
        end
      end
    end
  end
end

producer = Thread.new do
  begin
    loop do
      num = Random.rand(100)
      mutex.synchronize do
        queue.push num
      end
      push_data "producer", num
      if queue.size > 0
        threads.each {|t| t.wakeup}
      end
    end
  rescue => e
    p e
  end
end


def print_data(thread, num)
  puts "Thread #{thread} printed out number #{num}\n"
  sleep 1
end

def push_data(thread, num)
  puts "Thread #{thread} push #{num} to queue\n"
  sleep 3
end

threads.each do |t|
  t.join
end
producer.join
