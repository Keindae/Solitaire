#Matt Noblett
#Ruby Card Game
#Due 11/18/2016 11:59

#Author: Matt Noblett
#Purpse: This will create the deck of cards being used in the program. Creates instance variables, our map for our card to create the rank, the suit, and the value of each card.
#       Also creates and shuffles the deck array. 
#Input: N/a
#OutPut: N/A
class Deck
  def initialize
    @turn = 0;
    @result = 0;
    @hand = Array.new()
    @deck = Array(0..51)
    @deck.shuffle!
    @DeckSize = 52
    @suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
    @ranks = ["2", "3", "4", "5", "6", "7", "8", "9","10","Jack", "Queen", "King", "Ace"]
    @value = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1]
    @cardMap = Hash.new
    @id = 0
		@done = 0
    @checkUserInput = 0
    #Assigns the rank, suit, and the value of each card in the array I have created.  
    for i in 0..12
      @suits.each do |suit|
        @cardMap[@id] = [@ranks[i], suit, @value[i]]
        @id += 1
      end
    end
    #This will generate the frist three cards in our hand, then when play gets called, we are able to just draw one card and start going through the game
    #This probably isn't the correct way to go about starting the game, but oh well. 
		first = @deck.pop
		second = @deck.pop
		third = @deck.pop
    @hand.push(first)
    @hand.push(second)
    @hand.push(third)
  end
#Author: Matt Noblett
#Purpose: This is used to help determine what style of game is being played by the user.
#Input: checkUserInput - What style of game is to be played. It is either a 0 or 1
#Output: N/A
  def hMode(checkUserInput)
    @checkUserInput = checkUserInput
    if(@checkUserInput == 0)
      play()
    else
      while(@done == 0)
        play()
      end
    end
  end

#Author: Matt Noblett
#Purpose: This function either runs each individual play and presents it to the user, or it will hide all of the extra outputs and just present the score to the user. 
#Input: N/A
#Output: N/A
  def play()
		    @turn += 1
        if(@checkUserInput == 0)
		      puts "Starting the Turn: " + @turn.to_s
        end
				if !@deck.empty?
		    	card = @deck.pop()
					@hand.push(card)
          if(@checkUserInput == 0)
					  puts "New Card Drawn " + @cardMap[card][0].to_s + " of " + @cardMap[card][1].to_s
          end
        else
					@done = 1
				end
				if @done == 0
		    	checkCards()
          if(@checkUserInput == 0)
				    puts "End of the Turn " + @turn.to_s + ", your hand has the following: "
				    printHand()
          end
        else
          endGame()
        end
  end
#Author: Matt Noblett
#Purpose: This function checks the card values against each other and removes the correct cards based on what was defined in the handout.
#Input: N/A
#OutPut: N/A
  def checkCards()
		if @done == 0
      #Pops the first four values off the stack to be evaluated by the following if statements. 
		  first = @hand.pop
		  second = @hand.pop
		  third = @hand.pop
		  fourth = @hand.pop
      if (@checkUserInput == 0)
		    #Shows us the first four values that we are poping off the stack to check against each other and play the game. 
		    puts "####################################################################################################"
        puts "Poped Value " + @cardMap[first][0].to_s + " of " + @cardMap[first][1].to_s
		    puts "Poped Value " + @cardMap[second][0].to_s + " of " + @cardMap[second][1].to_s
		    puts "Poped Value " + @cardMap[third][0].to_s + " of " + @cardMap[third][1].to_s
		    puts "Poped Value " + @cardMap[fourth][0].to_s + " of " + @cardMap[fourth][1].to_s
		    puts "####################################################################################################"
      end
        #Here I check against the first and the fourth card in my hand. If they match, then I discard them
      #the entire hand and run the checkHandSize function to fill the users hand and then re run the chcek cards.
		  if(@cardMap[first][0] == @cardMap[fourth][0])
        if(@checkUserInput == 0)
        puts "####################################################################################################"
		    puts "Removing " + @cardMap[first][0].to_s + " of " + @cardMap[first][1].to_s
		    puts "Removing " + @cardMap[second][0].to_s + " of " + @cardMap[second][1].to_s
		    puts "Removing " + @cardMap[third][0].to_s + " of " + @cardMap[third][1].to_s
		    puts "Removing " + @cardMap[fourth][0].to_s + " of " + @cardMap[fourth][1].to_s
        puts "####################################################################################################"
        end
				checkHandSize()
			 	checkCards()
		    #Here I check the first and fourth suits against each other. This If it is true, then the middle two cards are discarded. 
		  elsif(@cardMap[first][1] == @cardMap[fourth][1])
		    if(@checkUserInput == 0)
        puts "####################################################################################################"
        puts "Removing " + @cardMap[second][0].to_s + " of " + @cardMap[second][1].to_s
		    puts "Removing " + @cardMap[third][0].to_s + " of " + @cardMap[third][1].to_s
		    puts "####################################################################################################"
        end
				@hand.push(first)
				@hand.push(fourth)
				checkHandSize()
				checkCards()
		  else
        #If all of the conditions have failed, then just push the values back onto the stack, and get out of the function.
				@hand.push(first)
				@hand.push(second)
				@hand.push(third)
				@hand.push(fourth)
			end
=begin
    elsif(@hand.length == 3 && @deck.length >= 1)
		    if(@checkUserInput == 0)
        puts "##########################################################################################################"
        puts "Removing " + @cardMap[second][0].to_s + " of " + @cardMap[second][1].to_s
		    puts "Removing " + @cardMap[third][0].to_s + " of " + @cardMap[third][1].to_s
		    puts "##########################################################################################################"
        end
				@hand.push(first)
				@hand.push(fourth)
				checkHandSize()
				checkCards()
		  else
        #If all the conditions fail, this will put all of the cards that were poped off the stack back onto the stack for tracking purposes. 
				@hand.push(first)
				@hand.push(second)
				@hand.push(third)
				@hand.push(fourth)
			end
=begin
    elsif(@hand.length == 3 && @deck.length >= 1)
      @hand.push(third)
      @hand.push(second)
      @hand.push(first)
      @hand.push(@deck.pop)
      checkCards()
    elsif (@hand.length == 2 && @deck.length >= 2 )
      @hand.push(second)
      @hand.push(first)
      @hand.push(@deck.pop)
      @hand.push(@deck.pop)
      checkCards()
    elsif (@hand.length == 1 && @deck.length >= 3)
      @hand.push(first)
      @hand.push(@deck.pop)
      @hand.push(@deck.pop)
      @hand.push(@deck.pop)
      checkCards()
    elsif(@deck.length == 0)
      puts "We are out of cards in the deck!"
      @hand.push(first)
      @hand.push(second)
      @hand.push(third)
      @hand.push(fourth)
      puts "Printing the cards left in our hand"
      printHand()
      puts @TotalPoints
      puts "Adding the points left in our hand" 
      puts @TotalPoints
      puts "Printing what is left in our deck"
      printDeck()
=end	
    end
  end
  def endGame
	 @totalPoints = 0
	  if @hand.length == 0
		  puts "WINNER WINNER CHICKEN DINNER - Unless you are vegan, than enjoy a salad."
      textWriter()
	  else
		  @hand.each do |card|
			  @totalPoints += @cardMap[card][2]
		  end
		  puts "Total Score:  " + @totalPoints.to_s
      textWriter()
	  end
  end
#Author: Matt Noblett
#Purpose: This makes sure that there are 4 cards in the players hand before moving back into the checkCards function and continuing through the game logic. 
#Input:
#OutPut:
  def checkHandSize
	  if @hand.length == 3
		  if @deck.length >= 1
			  first = @deck.pop
			  @hand.push(first)
        if(@checkUserInput == 0)
			    puts "New Card Drawn " + @cardMap[first][0].to_s + " of " + @cardMap[first][1].to_s
        end
      else
			  @done = 1
		  end
	  elsif @hand.length == 2
		  if @deck.length >= 2
			  first = @deck.pop
			  second = @deck.pop
			  @hand.push(first)
			  @hand.push(second)	
        if(@checkUserInput == 0)
			    puts "New Card Drawn " + @cardMap[first][0].to_s + " of " + @cardMap[first][1].to_s
			    puts "New Card Drawn " + @cardMap[second][0].to_s + " of " + @cardMap[second][1].to_s
        end
      else
			  @done = 1
		  end
	  elsif @hand.length == 1
		  if @deck.length >= 3
			  first = @deck.pop
			  second = @deck.pop
			  third = @deck.pop
			  @hand.push(first)
			  @hand.push(second)
			  @hand.push(third)
		    if(@checkUserInput == 0)
          puts "New Card Drawn " + @cardMap[first][0].to_s + " of " + @cardMap[first][1].to_s
			    puts "New Card Drawn " + @cardMap[second][0].to_s + " of " + @cardMap[second][1].to_s
			    puts "New Card Drawn " + @cardMap[third][0].to_s + " of " + @cardMap[third][1].to_s
        end
      else
			  @done = 1
		  end
	  elsif @hand.length == 0
		  if @deck.length >= 4
			  first = @deck.pop
			  second = @deck.pop
			  third = @deck.pop
			  fourth = @deck.pop
			  @hand.push(first)
			  @hand.push(second)
			  @hand.push(third)
			  @hand.push(fourth)
        if(@checkUserInput == 0)
			    puts "New Drawn Card " + @cardMap[first][0].to_s + " of " + @cardMap[first][1].to_s
			    puts "New Drawn Card " + @cardMap[second][0].to_s + " of " + @cardMap[second][1].to_s
			    puts "New Drawn Card" + @cardMap[third][0].to_s + " of " + @cardMap[third][1].to_s
			    puts "New Drawn Card " + @cardMap[fourth][0].to_s + " of " + @cardMap[fourth][1].to_s
		    end
        else
			  @done = 1
		  end
	  end
  end

#Author:Matt Noblett
#Purpose: Doesn't work. :(
#Input: N/a
#OutPUt:N/A
  def textWriter

    File.open("Leaders.txt", 'w'){|file| file.write("#{@totalPoints}")}


  end
#Author: Matt Noblett
#Purpose: Prints the deck to the user. 
#Input: N/A
#Output: N/A
  def printDeck
    @deck.each do |card|
      puts @cardMap[card][0].to_s + " of " + @cardMap[card][1].to_s
    end
  end
#Author:Matt Noblett
  #Purpose: To print the hand to the user and also was very helpful when error checking. Used to help the player know what is going on when they are playing turn by turn. 
#Input: N/A
#OutPut: N/A
  def printHand
    @hand.each do |card|
      puts @cardMap[card][0].to_s + " of " + @cardMap[card][1].to_s
    end
  end
end
