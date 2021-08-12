class Hangman
  def initialize
    @word = game_settings.sample
    @lives = 7

    @word_teaser = ''
    @word[:word].size.times do
      @word_teaser += '_ '
    end
  end

  def game_settings
    [
      { word: 'jogging', hint: 'We are not walking...' },
      { word: 'celebrate', hint: 'Remembering special moments' },
      { word: 'continent', hint: 'There are 7 of these' },
      { word: 'exotic', hint: 'Not from around here...' }
    ]
  end

  def print_teaser(last_guess = nil)
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser(last_guess)
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      replace_blanks_with_guess(new_teaser, last_guess, letter, index)
    end

    @word_teaser = new_teaser.join(' ')
  end

  def replace_blanks_with_guess(new_teaser, last_guess, letter, index)
    new_teaser[index] = last_guess if letter == '_' && @word[:word][index] == last_guess
  end

  def make_guess
    # guard: no lives left
    if @lives == 0
      puts 'Game over... better luck next time!'
      return
    end

    puts 'Enter a letter'
    guess = gets.chomp

    # guard: exit condition
    if guess == 'exit'
      puts 'Thank you for playing!'
      return
    end

    # play
    if guess.empty?
      puts 'Empty input, try again, please!'
    elsif guess.length > 1
      puts 'only guess 1 letter at a time please!'
    elsif @word[:word].include?(guess)
      puts 'You are correct!'
      print_teaser(guess)
      if @word[:word] == @word_teaser.split.join
        puts 'Congratulations... you have won this round!'
        return
      end
    else
      @lives -= 1
      puts "Sorry... you have #{@lives} lives left. Try again!"
    end
    make_guess
  end

  def begin
    # ask user for a letter
    puts "New game started... your word is #{@word[:word].size} characters long"
    puts "To exit game at any point type 'exit'"
    print_teaser

    puts "Clue: #{@word[:hint]}"

    make_guess
  end
end
