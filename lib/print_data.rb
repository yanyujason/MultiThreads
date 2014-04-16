require 'thread'
require '../lib/semaphore.rb'

@max = 2
@thread_number = 5

mutex = Mutex.new
semaphores = Semaphore.new(@max)

resource = ConditionVariable.new

queue = Queue.new
(1..15).each do |i|
  queue.push i
end

threads =[]

@thread_number.times do |x|
  threads << Thread.new do
    loop do
      semaphores.synchronize do
        num = 0
        mutex.synchronize do
          if !queue.empty?
            num = queue.pop
          else
            resource.wait mutex
          end
        end
        if num != 0
          print_data x, num
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
        resource.broadcast
      end
      push_data "producer", num
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
