require_relative './main.rb'
require 'yaml'

class Game
  include Tools
  attr_reader :guess_letters, :secret_code, :correct_letters

  def initialize(guess_letters = [], secret_code = generate_random_word, turns = 8, incorrect_letters = [], correct_letters = [])
    @turns = turns
    @guess_letters = guess_letters
    @incorrect_letters = incorrect_letters
    @correct_letters = correct_letters
    @secret_code = secret_code
    @game_continue = false
    @game_saved = false
  end
  def save_game(name)
    serialized_string = YAML.dump ({
      :turns => @turns,
      :guess_letters => @guess_letters,
      :correct_letters => @correct_letters,
      :incorrect_letters => @incorrect_letters,
      :secret_code => @secret_code,
      :game_won => @game_won
    })
    save_file = File.open("#{name}.yaml", "w")
    save_file.puts serialized_string
    save_file.close
    puts "Your game has been saved as #{name}.yaml! Thank you for playing"
    save_file_names(name)
    @game_saved = true
  end

  def self.load_game(save_file_name)
    data = YAML.load(File.read("#{save_file_name}.yaml"))
    self.new(data[:guess_letters], data[:secret_code], data[:turns], data[:incorrect_letters], data[:correct_letters]).start_game
  end

  def self.introduction
    puts <<-Introduction
    Hello! This is a hangman game implementation of ruby. In this version of the game
    you get 8 turns for each game. On the start of the game you can choose to load a
    game you have saved before or choose to start a new game. As default you get 8 turns
    for each game and you can choose to save the game at every turn, or you can make a
    guess for the whole word if you think you have got the word.

    To make a word guess you should type: guess [the word you guess]. You should add guess
    keyword in front of the word guess you are making. EG: guess banana. This means you are
    guessing as banana. If you make a wrong guess however, the penalty is minus 2 turns.

    To save the game, simply type in 'save' and the game will save your current progress as 
    a game file that can be loaded later on.

    To simply guess a letter, just enter a letter.

    Good luck and Have Fun!!!
    - by bilguun-ocean
    Introduction
    puts "Would you like to load a previous game? Type in yes to load and anything else to start a new game"

    answer = gets.chomp.downcase

    if answer == 'y' || answer == 'yes'
      puts "These are the current saved files: "
      display_save_files()
      begin
        print "Enter the name of your save file: "
        save_file = gets.chomp.downcase.strip
        load_game(save_file)
      rescue
        puts 'There is no such save file! '
      end
    else
      self.new.start_game()
    end
  end

  def start_game
    until @turns == 0 || @game_continue || @game_saved
      display_clue(secret_code, guess_letters)
      puts "INCORRECT LETTERS YOU HAVE ENTERED: "
      p @incorrect_letters.join(' ')
      puts "CORRECT LETTERS YOU HAVE ENTERED: "
      p @correct_letters.join(' ')
      print "Enter your guess letter: "
      unless input()
        until input()
        end
      end
      @turns -= 1
      unless @game_saved || @game_continue
        puts "\n"
        puts "\n"
        puts "TURNS LEFT: #{@turns}"
        check_winner
      end
    end
  end

end

Game.introduction
