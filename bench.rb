require "benchmark"
#require "benchmark/memory"

def sum(a)
  a.reduce(:+)
end

def my_xbonacci(signature, n)
   count_from_index = 0
   digits_to_sum = signature.length
   until signature.length == n
     next_num = sum(signature.slice(count_from_index, digits_to_sum))
     signature.push(next_num)
     count_from_index+=1
   end
   signature
end

def their_xbonacci(s,n)
   n.times.map { s << s.inject(:+); s.shift }
end

def benchmark(signature, n)
  Benchmark.bmbm do |x|
     x.report("My xbonacci") {my_xbonacci(signature, n)}
     x.report("Their xbonacci") {their_xbonacci(signature, n)}
   end

  #Benchmark.memory do |x|
  #   x.report("My xbonacci") {my_xbonacci(signature, n)}
  #   x.report("Their xbonacci") {their_xbonacci(signature, n)}
  #end
end

benchmark([1, 2, 3], 1000)
