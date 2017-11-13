def spin(passed_bet, wager)
  @nums = [
    { number: 0, color: "none" },  
    { number: 1, color: "red" },
    { number: 2, color: "black" },
    { number: 3, color: "red" },
    { number: 4, color: "black" },
    { number: 5, color: "red" },
    { number: 6, color: "black" },
    { number: 7, color: "red" },
    { number: 8, color: "black" },
    { number: 9, color: "red" },
    { number: 10, color: "black" },
    { number: 11, color: "black" },
    { number: 12, color: "red" },
    { number: 13, color: "black" },
    { number: 14, color: "red" },
    { number: 15, color: "black" },
    { number: 16, color: "red" },
    { number: 17, color: "black" },
    { number: 18, color: "red" },
    { number: 19, color: "red" },
    { number: 20, color: "black" },
    { number: 21, color: "red" },
    { number: 22, color: "black" },
    { number: 23, color: "red" },
    { number: 24, color: "black" },
    { number: 25, color: "red" },
    { number: 26, color: "black" },
    { number: 27, color: "red" },
    { number: 28, color: "black" },
    { number: 29, color: "black" },
    { number: 30, color: "red" },
    { number: 31, color: "black" },
    { number: 32, color: "red" },
    { number: 33, color: "black" },
    { number: 34, color: "red" },
    { number: 35, color: "black" },
    { number: 36, color: "red" },
    { number: 00, color: "none" }
  ]
  rand_num = @nums.sample
  bet = passed_bet
  eval_spin(rand_num, passed_bet, wager)  
end

def eval_spin(num, bet, wager)
  arr_num = num[:number]
  arr_col = num[:color]
  puts "Your bet was: " + bet.capitalize
  print "The ball rests on: "
  print "#{arr_num}" + " " + "#{arr_col}".capitalize + "\n"
  case bet
    when "red", "black"
      if arr_col == bet
        odds = 1
        success(wager, odds)
      else
        failure
      end
    when "even"                         #condense even + odd
      if arr_num.even? == true
        success(wager, odds)
      else
        failure
      end
    when "odd"
      if arr_num.odd? == true
        success(wager, odds)
      else
        failure
      end
    when "low"                          #condense low + high
      if arr_num != 0
        if arr_num < 19
          success(wager, odds)
        else
          failure
        end
      else
        puts "oh no!!!!!"
      end
    when "high"
      if arr_num != 0
        if arr_num > 19
          success(wager, odds)
        else
          failure
        end
      else
        puts "oh no!!!!!"
      end
  end
end

def success(wager, odds)
  winnings = wager + (wager * odds)
  puts "Congratulations!"
  print "You win: $"
  puts winnings
  @temp_wallet = @temp_wallet + winnings
  puts "Your wallet now holds $" + "#{@temp_wallet}"
  play
end

def failure
  puts "You lose"
  puts "Your wallet now holds $" + "#{@temp_wallet}"
  @temp_wallet == 0 ? exit : play
end