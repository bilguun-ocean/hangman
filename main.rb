
#test here
module Tools 
  def generate_random_word
    dictionary = File.open('google-10000-english-no-swears.txt', 'r')
    dictionary.rewind
    characters = dictionary.readlines.select {|word| word.chomp.length >= 5 && word.chomp.length <= 12}
    secret_word = characters.sample
  end

  def display_clue(word, guess)
    clue = []
    word = word.split('')
    word.each do |letter|
      if guess.include?(letter)
        clue.push(letter)
      else
        clue.push('_')
      end
    end
    p clue.join(' ')
  end
  
  def sort_correct_or_incorrect_letter(word, guess)
    if word.include?(guess)
      @correct_letters.push(guess)
    else
      @incorrect_letters.push(guess)
    end
    guess_letters.push(guess)
  end

  def incorrect_letters(word, guess)
    incorrect_letters = []
    guess.each do |guess|
      unless word.include?(guess)
        incorrect_letters.push(guess)
        @incorrect_letters.push(guess)
      end
    end
    puts "Incorrect letters you have chose: #{incorrect_letters.join(" ")}"
  end

  def get_guess_input
    puts "Enter your guess letter: "
    input_letter = gets.chomp
  end

  def input 
    input_letter = gets.chomp.downcase
    if input_letter.empty?
      puts "Please enter a value: "
    elsif !(input_letter.ord.between?(97, 122))
      puts "Please enter a valid letter: "
    elsif input_letter.length > 1
      puts "Please enter a single letter: "
    elsif @guess_letters.include?(input_letter)
      puts "You have chosen this letter before, try another."
    else
      sort_correct_or_incorrect_letter(@secret_code, input_letter)
    end
  end


  def how_many_turns_left
    puts "You have #{@turns} guesses left"
  end

  def check_winner()
    if @secret_code.split('').uniq == @correct_letters 
      puts "You have won the game with #{@turns} turns left!"
      @game_won = true
    elsif @turns == 0
      puts "You have lost the game :("
      puts "The answer was #{@secret_code}"
    end
  end
end
