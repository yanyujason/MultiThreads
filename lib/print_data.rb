require "thread"
puts "Synchronize Thread"

@data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
@counts = 0
@max = 2
@time = 3


def print_data(num)
  @counts += 1
  @data = @data[1..-1]
  sleep num
  @counts -= 1
end

t1 = Time.now

thread_1 = Thread.new do
  while @data.size > 0 do
    if @counts < @max
      print_data @time
      puts "thread 1"
    end
  end
end

thread_2 = Thread.new do
  while @data.size > 0 do
    if @counts < @max
      print_data @time
      puts "thread 2"
    end
  end
end

thread_3 = Thread.new do
  while @data.size > 0 do
    if @counts < @max
      print_data @time
      puts "thread 3"
    end
  end
end

thread_4 = Thread.new do
  while @data.size > 0 do
    if @counts < @max
      print_data @time
      puts "thread 4"
    end
  end
end

thread_5 = Thread.new do
  while @data.size > 0 do
    if @counts < @max
      print_data @time
      puts "thread 5"
    end
  end
end

thread_1.join
thread_2.join
thread_3.join
thread_4.join
thread_5.join

t2 = Time.now

puts t2 - t1