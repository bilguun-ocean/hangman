
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
    incorrect_letters(word, guess)
  end
  
  def incorrect_letters(word, guess)
    incorrect_letters = []
    guess.each do |guess|
      unless word.include?(guess)
        incorrect_letters.push(guess)
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

    if !(input_letter.ord.between?(97, 122))
      puts "Please enter a valid letter: "
    elsif input_letter.length > 1
      puts "Please enter a single letter: "
    elsif @guess_letters.include?(input_letter)
      puts "You have chosen this letter before, try another."
    else
      @guess_letters.push(input_letter)
    end
  end

  def validate_input(character)
    unless (character.ord.between?(65,90)) || (character.ord.between?(97,122))
      puts "Please enter a valid letter"
    end
    if character.length > 1
      puts "Please enter a single letter"
    elsif @guess_letters.include?(character)
      puts "You have chose this letter before, try another letter"
    else
      character
    end
  end

  def how_many_turns_left
    puts "You have #{@turns} guesses left"
  end

  def check_winner
    if @game_won
      puts "You have won the game in #{@turns} turns!"
    else
      puts "You have lost the game :(. The secret code was #{@secret_code}"
    end
  end
end
