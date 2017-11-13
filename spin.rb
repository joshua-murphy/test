def spin(passed_bet, wager)
  @nums = [
    { number: 0, color: nil},  
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
    { number: 00, color: nil }
  ]

  rand_num = @nums.sample
  bet = passed_bet
  eval_spin(rand_num, passed_bet, wager)  
end

def eval_spin(num, bet, wager)
  arr_num = num[:number]
  arr_col = num[:color]
  puts ""
  puts "Your call is: " + bet.capitalize
  print "The ball rests on: "
  print "#{arr_num}" + " " + "#{arr_col}".capitalize + "\n"
  if arr_num == 0
    failure
  end
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
        odds = 1
        success(wager, odds)
      else
        failure
      end
    when "odd"
      if arr_num.odd? == true
        odds = 1
        success(wager, odds)
      else
        failure
      end
    when "low"                          #condense low + high
        if arr_num < 19
          odds = 1
          success(wager, odds)
        else
          failure
        end
    when "high"
        if arr_num > 19
          odds = 1
          success(wager, odds)
        else
          failure
        end
    when "dozen"
      case @dozen_opt
        when 1
          arr_num < 13 ? success(wager, 2) : failure
        when 2
          arr_num.between?(13, 25) ? success(wager, 2) : failure
        when 3
          arr_num > 24 ? success(wager, 2) : failure
      end
    when "column"
      case @column_opt
        when 1
          arr_num % 3 == 1 ? success(wager, 2) : failure
        when 2
          arr_num % 3 == 2 ? success(wager, 2) : failure
        when 3
          arr_num % 3 == 0 ? success(wager, 2) : failure
      end
  end
end

def success(wager, odds)
  winnings = wager + (wager * odds)
  puts "Congratulations!"
  print "Net winnings: $"
  puts wager * odds
  @temp_wallet = @temp_wallet + winnings
  puts "Your wallet now holds $" + "#{@temp_wallet}"
  play
end

def failure
  puts "You lose!"
  puts "Your wallet now holds $" + "#{@temp_wallet}"
  @temp_wallet == 0 ? exit : play
end