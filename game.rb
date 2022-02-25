require_relative './main.rb'

class Game
  include Tools
  attr_reader :guess_letters, :secret_code

  def initialize
    @turns = 8
    @guess_letters = []
    @incorrect_letters = []
    @secret_code = generate_random_word
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
      @turns -= 1
    end
    check_winner
  end

end

test = Game.new
test.start_game