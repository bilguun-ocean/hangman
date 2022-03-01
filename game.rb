require_relative './main.rb'

class Game
  include Tools
  attr_reader :guess_letters, :secret_code, :correct_letters

  def initialize(guess_letters = [], secret_code = generate_random_word, turns = 8, incorrect_letters = [], correct_letters = [])
    @turns = turns
    @guess_letters = guess_letters
    @incorrect_letters = incorrect_letters
    @correct_letters = correct_letters
    @secret_code = secret_code
    @game_won = false
  end

  def start_game
    until @turns == 0 || @game_won
      how_many_turns_left()
      puts "Enter your guess letter: "
      unless input()
        until input()
        end
      end
      display_clue(secret_code, guess_letters)
      p @correct_letters
      p @incorrect_letters
      @turns -= 1
      check_winner
    end
  end

end

test = Game.new
test.start_game