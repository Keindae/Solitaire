require_relative 'Deck'

#Prompts the user for input. 
puts "Card Game Thing"
puts "Please enter an (X) to exit, a (L) to display the leaderboard, a (D) to display the current deck, a (P) to watch the game unfold (MAKE SURE YOU CONTINUE TO HIT ENTER), and a (H) to let it rip"

userInput = gets.upcase!
#Simple switch statement to get the user input and correctly choose the right function. 
until userInput == "X\n"

  case userInput.to_s
  when "X\n"
    puts "WE DONE!"
  when "L\n"
    newGameDeck = Deck.new
    newGameDeck.fileReader()
  when "D\n"
    newGameDeck = Deck.new
    newGameDeck.printDeck()
  when "P\n"
    newGameDeck = Deck.new
    newGameDeck.hMode(0)
  when "\n"
    newGameDeck.hMode(0)
  when "H\n"
    newGameDeck = Deck.new
    newGameDeck.hMode(1)
  end
  userInput = gets
  if(userInput != "\n")
    userInput.upcase!
  end
end

