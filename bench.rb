# frozen_string_literal: true

require 'benchmark'
# require "benchmark/memory"

def sum(input)
  input.reduce(:+)
end

def my_xbonacci(signature, number)
  count_from_index = 0
  digits_to_sum = signature.length
  until signature.length == number
    next_num = sum(signature.slice(count_from_index, digits_to_sum))
    signature.push(next_num)
    count_from_index += 1
  end
  signature
end

def their_xbonacci(signature, number)
  number.times.map do
    signature << signature.inject(:+)
    signature.shift
  end
end

def benchmark(signature, number)
  Benchmark.bmbm do |x|
    x.report('My xbonacci') { my_xbonacci(signature, number) }
    x.report('Their xbonacci') { their_xbonacci(signature, number) }
  end

  # Benchmark.memory do |x|
  #   x.report("My xbonacci") {my_xbonacci(signature, n)}
  #   x.report("Their xbonacci") {their_xbonacci(signature, n)}
  # end
end

benchmark([1, 2, 3], 1000)
