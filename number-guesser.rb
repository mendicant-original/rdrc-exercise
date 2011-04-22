#!/usr/bin/env ruby
require 'pp'
class Game
  def initialize
    @guesses = []
    @histogram = {5=>0.103571747776735, 6=>0.129887831255307, 1=>0.0653125977566251, 7=>0.172213656879832, 2=>0.0721332171426018, 8=>0.0966282343477678, 3=>0.109029360504089, 9=>0.0615922599097287, 4=>0.138255798364392, 10=>0.0513752960629218}
    @user_histogram = Hash[(1..10).map {|i| [i, 0]}]
    @right = 0
    @user_total = 0.0
  end
  
  def play
    loop do
      puts "Guess a number between 1-10: " 
      x = gets.chomp.to_i
      if x > 10 || x < 1
        puts "No good must be greater than 0 and less than 11"
      else  
        computer_guess = make_guess
        @guesses << x
        update(x, computer_guess)
        if computer_guess == @guesses.last
          puts "YAY I got it right"
        else
          puts "NO I got it wrong: I guess #{computer_guess} and you guessed #{@guesses.last}"
        end
        
      end
    end
  end
  
  
  def update(x, computer_guess)
    @user_histogram[x] += 1
    @user_total += 1
    
    if computer_guess == x
      @right += 1  
    end
    
    puts "Accuracy: #{@right / @user_total}"
    
    
    # puts "Histograms"
    # pp(Hash[@user_histogram.map {|k,v| [k, percent(k)]}])
    # pp(@histogram)
    # pp(Hash[difference.sort_by {|obj| obj[1]}])
  end
  
  
  def difference
    @histogram.map do |k,v|
      
      [k, v - percent(k)]
    end
  end
  
  def percent(index)
    if @user_total != 0.0
      (@user_histogram[index] / @user_total)
    else
      0
    end
  end
  
  def make_guess
    difference.sort_by {|obj| obj[1]}.last.first
  end
end


game = Game.new
game.play
  
