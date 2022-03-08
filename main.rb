
#test here
module Tools 
  def generate_random_word
    dictionary = File.open('google-10000-english-no-swears.txt', 'r')
    dictionary.rewind
    characters = dictionary.readlines.select {|word| word.chomp.length >= 5 && word.chomp.length <= 12}
    secret_word = characters.sample.strip
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
    elsif input_letter.strip == "save"
      print "Enter a name for your save: "
      save_name = gets.chomp
      save_game(save_name)
    elsif input_letter[0..4].strip == "guess"
      if input_letter[5..].strip == @secret_code
        puts "You have guessed the secret code!"
        @game_continue = true
        @turns 
      else
        puts "Failed the guess. 2 turns has been subtracted as a penalty"
        @turns -= 1
      end
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
  end


  def check_winner()
    if @game_continue || @secret_code.split('').uniq == @correct_letters 
      puts "You have won the game with #{@turns} turns left!"
      @game_continue = true
    elsif @turns == 0
      puts "You have lost the game :("
      puts "The answer was #{@secret_code}"
    end
  end

  def save_file_names(save_file)
    save_file_txt = File.open('save_names.txt', 'a')
    save_file_txt.puts save_file
    save_file_txt.close
  end

  def display_save_files
    save_file = File.open('save_names.txt', 'r')
    puts save_file.readlines
  end