# Following are the solutions for the 2 problems along with descriptions

=begin
Problem 1
A DNA strand is represented by a string of the characters A, C, G, and T, each of which
represents a nucleotide. The hamming distance between two DNA strands of the same length is
equal to the number of positions in which they differ. Hamming distance is used in
bioinformatics as a measure of the similarity of two strings.

Write a DNA class that gets 
initialized with a string of nucleotide characters. An instance of DNA responds to the to_s,
length, hamming_distance, contains, positions, and frequencies messages. Where a and b are
DNA instances of the same length, the message send a.hamming_distance(b) returns the
Hamming distance between a and b. a.contains(b) returns true if b appears as a substring in a,
and returns false otherwise. a.positions(n) returns an array of the (zero-based) positions in
increasing order in which the nucleotide n occurs. Frequencies returns a hash that maps each of
the four nucleotides to the number of times it occurs in the DNA instance.**
=end

class DNA
    attr_accessor :strand

    # Default so @strand can be initialized mannually
    def initialize(dna_strand='')
        @strand = dna_strand
    end

    def length
        strand.length
    end

    def to_s
        strand
    end

    def contains(substring)
        # Check for DNA object OR partial strand
        if substring.class == DNA
            strand.include? substring.strand
        else
            strand.include? substring
        end
    end

    def positions(n = '')
        positions = []
        currentIndex = -1

        # Return all indexs for substring n (of any length)
        if (n != '')
            loop do
                currentIndex = strand.index(n, currentIndex + 1)
                if currentIndex
                    positions << currentIndex
                else
                    break
                end
            end
        end
      
        positions
    end

    def hamming_distance(other_dna)
        if other_dna.class != DNA
            raise ArgumentError, "argument needs to be dna"
        end
        if length != other_dna.length
            raise ArgumentError, "dnas of different lengths"
        end

        # Distance = count of all nucleotide/positions that are not the same
        distance = 0
        (0...length).each do |i|
            if strand[i] != other_dna.strand[i]
                distance += 1
            end
        end
        distance
    end

    def frequencies
        # Hashmap to hold counts of nucleotide
        frequency_hash = { 'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0 }
        strand.chars.each do |char|
            frequency_hash[char] += 1
        end
        frequency_hash
    end
end

puts dna1 = DNA.new('ATTGCC')        # ATTGCC
puts dna1.length                     # 6
puts dna1                            # ATTGCC
puts dna1.contains('TGC')            # true
puts dna1.contains(DNA.new('AT'))    # true
puts dna1.contains('GG')             # false
p dna1.positions('T')                # [1, 2]
puts dna2 = DNA.new('GTTGAC')        # GTTGAC
puts dna1.hamming_distance(dna2)     # 2
puts dna1.hamming_distance(dna1)     # 0
p dna1.frequencies                   # {"A"=>1, "T"=>2, "G"=>1, "C"=>2}
# dna1.hamming_distance(DNA.new('AT')) # ArgumentError: dnas of different lengths


=begin
Problem 2
Write a SumIntegers class with a run method that repeatedly reads a sequence of integers from
the console and prints their sum. Whenever any of the inputs is illegal, meaning it cannot be
parsed as an integer, the method prints Bad input. The run method continues processing input,
line by line, until the user enters quit. Here is a transcript.
=end

class SumIntegers
    def run

        puts "Enter numbers separated by spaces on one line (type 'quit' to exit):"

        loop do
            # Get full line of numbers
            input = gets.chomp
            sum = 0

            if input.downcase == "quit"
                break
            end

            begin
                # Split numbers, add together and return sum
                entries = input.split(' ')
                for item in entries
                    sum += Integer(item)
                end
                puts "** #{sum}"
            rescue ArgumentError
                puts "Bad input" # Handle bad input
            end
        end

        puts "goodbye"
    end
    end

sum_integers = SumIntegers.new
sum_integers.run

=begin
Examples (enter on one line):
3 4  5 -> **12
-17 0 22 -> ** 5
8 -> **8
5 hello 7 -> Bad input
1 2 3 44 -> 50
quit -> goodbye
=end