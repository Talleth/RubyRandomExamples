# Following are the solutions for the 2 problems along with descriptions

=begin
Write a Game class which initializes with a dictionary of legal words. (I've included a dictionary
in this assignment, and we will talk about how to include it in your program.) Calling game.play
starts a new game; this can be called repeatedly to play multiple games. Each new game selects a
random target word from the dictionary which the player then tries to discover in a sequence of
up to six rounds.

In each round, the player guesses a new word. The game provides feedback for each letter in the
guess with respect to the target word, indicating whether the guess letter is an exact match
(exact), or appears in the target word but in a different position (included), or does not appear in
the target word at all (miss). These feedback messages can take either of two forms, depending
on whether the game's color property is true or false. If color is false, use the markers *, ^, and ' '
(blank) to indicate exact, included, and miss respectively. If color is true, each guess letter is
colored green, yellow, or default to indicate exact, included, and miss.
=end

require "colorize"
require_relative "words.rb"

class Game

    attr_accessor :color

    def initialize(words_array)
        # Initialize word dictionary and default color configuration
        @words_array = words_array
        @color = false
    end

    def play
        target_word = @words_array.sample.downcase
        puts "Guess five letter words:"

        # Use strategy pattern by initializing the proper strategy
        # Use the differing strategy based on the color configuration
        outputClass = @color == true ? ColorOutput.new : StandardOutput.new

        # Six tries to play
        6.times do |index|
            guess = gets.chomp.downcase.strip

            if (validate_guess(guess))
                puts outputClass.generate_output(target_word, guess)

                # The game is won
                if guess == target_word
                    puts "You won in #{index+ 1} guesses!"
                    return
                end
            else
                puts "Invalid guess; try again"
            end
        end

        # All tries are up
        puts "You lose: the word was '#{target_word}'."
    end

    private

    def validate_guess(guess)
        # The guess has to be proper length AND be an actual word
        # This test also assumes a larger dictionary later (with any length of words)
        result = true;
            if (guess.length != 5 || !@words_array.include?(guess))
                result = false
            end
        result;
    end
end

# Strategy pattern classes start ****************
class Output
    def generate_output(target_word, guess)
        raise 'Abstract method called'
    end
end

class StandardOutput < Output
    def generate_output(target_word, guess)
        result_array = []

        # Test every character, generate standard output
        target_word.chars.each_with_index do |char, index|
            if char == guess[index]
                result_array[index] = "*"
            elsif target_word.include?(guess[index])
                result_array[index] = "^"
            else
                result_array[index] = " "
            end
        end

        # Join result back to a string and return
        result_array.join
    end
end

class ColorOutput < Output
    def generate_output(target_word, guess)
        result_array = []

        # Test every character, generate color output
        target_word.chars.each_with_index do |char, index|
            if char == guess[index]
                result_array[index] = guess[index].green
            elsif target_word.include?(guess[index])
                result_array[index] = guess[index].yellow
            else
                result_array[index] = guess[index]
            end
        end

        # Join result back to a string and return
        result_array.join
    end
end
# Strategy pattern classes end ******************

# Example usage:
gm = Game.new(Wordle::Words)
# gm.color = true
gm.play