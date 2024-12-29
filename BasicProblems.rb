# Following are the list of 8 problems including descriptions

# Problem 1
# Where a is an array, duple(n, a) returns a new array where each element of a is duplicated n
# times.
# print duple(4, [1,2,3]) # [1,1,1,1,2,2,2,2,3,3,3,3]
# print duple(1, [1,2,3]) # [1,2,3]
# print duple(0, [1,2,3]) # []

def duple (n, a)
    result = Array.new

    a.each do |x|
        n.times do
            result << x
        end
    end

    return result
end

p duple(4, [1,2,3]) # [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]
p duple(1, [1,2,3]) # [1, 2, 3]
p duple(0, [1,2,3]) # []
p duple(0, [])      # []
p duple(1, [])      # []

# Problem 2
# The Fibonacci sequence fib is defined thus: fib(1) = fib(2) = 1, and fib(n) = fib(n−1)+fib(n−2) for
# n>2. Write a function fib_array(n) that returns an array containing the first n values of the
# Fibonacci sequence. For example:
# print fib_array(1) # [1]
# print fib_array(2) # [1, 1]
# print fib_array(10) # [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

def fib_array(n)
    result = Array.new

    n.times do |i|
        # First two values will be 1
        if i == 0 or i == 1
            result << 1
        else
            result << result[i-1] + result[i-2]
        end
    end

    return result;
end

p fib_array(0)  # []
p fib_array(1)  # [1]
p fib_array(2)  # [1, 1]
p fib_array(10) # [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

# Problem 3
# Write a function fib(n) that returns the n’th Fibonacci value. Your function should run in time
# linear in input n.
# print fib(10) # 55
# print fib(100) # 354224848179261915075

def fib(n)
    def fib_fast(n, map = {})
        if n == 0
            return 0
        elsif n == 1 or n == 2
            return 1
        elsif map.key?(n)
            return map[n]
        else
            map[n] = fib_fast(n-1, map) + fib_fast(n-2, map)
            return map[n]
        end
    end

    return fib_fast(n)
end

p fib(10)  # 55
p fib(100) # 354224848179261915075

# Problem 4
# A palindrome is a string that reads the same forward and backward. Write a function
# is_palindrome(s) that takes a string s and returns true if s is a palindrome and returns false
# otherwise.
# >> is_palindrome('abba')
# => true
# >> is_palindrome('a')
# => true
# >> is_palindrome('peach')
# => false

def is_palindrome(s)
    if s.length <= 1
        return true
    elsif s[0] == s[-1]
        return is_palindrome(s[1..-2])
    else
        return false
    end
end

puts is_palindrome('abba')  # true
puts is_palindrome('a')     # true
puts is_palindrome('peach') # false

# Problem 5
# A decimal number contains consecutive digits if some digit occurs adjacent to itself. Write the
# function consecutive_digits(n) that returns true if n contains consecutive digits and false
# otherwise.
# >> consecutive_digits 2
# => false
# >> consecutive_digits 22
# => true
# >> consecutive_digits 54332
# => true
# >> consecutive_digits 123454321
# => false

def consecutive_digits(n)
    n_string = n.to_s

    if n_string.length <= 1
        return false
    elsif n_string[0] == n_string[1]
        return true
    else
        consecutive_digits(n_string[1..-1].to_i)
    end
end

puts consecutive_digits 2         # false
puts consecutive_digits 22        # true
puts consecutive_digits 54332     # true
puts consecutive_digits 123454321 # false

# Problem 6
# Write a function insert(x, a) that takes an integer x and an array a of integers in nondecreasing
# order and returns a new sorted array that includes x and the integers of a. Your function should
# run in linear time (e.g., do not use sort). It should also not modify a.
# >> a = [2, 4, 5, 9, 12]
# => [2, 4, 5, 9, 12]
# >> insert(5, a)
# => [2, 4, 5, 5, 9, 12]
# >> insert(10, a)
# => [2, 4, 5, 9, 10, 12]
# >> insert(20, a)
# => [2, 4, 5, 9, 12, 20]
# >> a
# => [2, 4, 5, 9, 12]

def insert(x, a)
    result = Array.new
    inserted = false

    a.each do |value|
        if x < value and !inserted
            result << x
            inserted = true
        end
        result << value
    end

    if !inserted
        result << x
    end

    return result
end

a = [2, 4, 5, 9, 12] # [2, 4, 5, 9, 12]
p insert(5, a)       # [2, 4, 5, 5, 9, 12]
p insert(10, a)      # [2, 4, 5, 9, 10, 12]
p insert(20, a)      # [2, 4, 5, 9, 12, 20]
p a                  # [2, 4, 5, 9, 12]

# Problem 7
# Write the function insertion_sort(a) that takes an array of numbers and returns an array of the
# same values in nondecreasing order, without modifying a. Your function should implement the
# insertion sort algorithm, using the insert function written in the previous problem.
# >> b = Array.new(12) {Random.rand(100)}
# => [30, 81, 43, 95, 24, 38, 64, 56, 74, 70, 33, 60]
# >> insertion_sort(b)
# => [24, 30, 33, 38, 43, 56, 60, 64, 70, 74, 81, 95]
# >> b
# => [30, 81, 43, 95, 24, 38, 64, 56, 74, 70, 33, 60]
# >> insertion_sort(b) == b.sort
# => true
 
def insertion_sort(a)
    if a.length < 1
        a
    else
        temp = insertion_sort(a[1..-1])
        insert(a[0], temp)
    end
end

b = Array.new(12) {Random.rand(100)} # Creates random array of 12 bytes
p b                                  # Show array created
p insertion_sort(b)                  # Returns random array sorted
p b                                  # Demos that b has not changed
puts insertion_sort(b) == b.sort     # Double checks against built in sorting algorithm

# Problem 8
# The factorial of a nonnegative integer n is defined fact(n)=n!=n´(n−1)´(n−2)´…´1. It can also
# be defined recursively: fact(0)=1 and fact(n)=n´fact(n−1) for n>0. Define five different versions
# of the function fact, named fact1, …, fact5. Try to achieve significant variety among your
# functions.
# >> fact1(5)
# => 120
# >> fact2(40)
# => 815915283247897734345611269596115894272000000000

# Fact 1 - Recursive clean
def fact1(n)
    return 0 if n == 0
    return 1 if n == 1
    return n * fact1(n-1);
end

# Fact 2 - Recursive without returns
def fact2(n)
    if n == 0 then 0
    elsif n == 1 then 1
    else
        n * fact1(n-1)
    end
end

# Fact 3 - Iterative while
def fact3(n)
    result = n
    while n > 1 do
        n -= 1
        result = result * n
    end
    return result
end

# Fact 4 - Iterative backwards counter
def fact4(n)
    result = n
    (n-1).downto(1) do |val|
        result = result * val
    end
    return result
end

# Fact 5 - Iterative forward
def fact5(n)
    if n == 0
        return 0
    end
    result = 1
    n.times do |index|
        result = result * (index+1)
    end
    return result
end

# puts fact1(5)  # 120
# puts fact1(40) # 815915283247897734345611269596115894272000000000
# puts fact1(0)  # 0