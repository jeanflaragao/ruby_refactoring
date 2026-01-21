require 'date'

class User
  attr_accessor :id, :name, :email
  attr_reader :balance

  def initialize(id:, name:, email:, balance: 0.0)
    @id = id
    @name = name
    @email = email
    @balance = balance
  end

  def has_sufficient_funds?(amount)
    @balance >= amount
  end

  def add_balance(amount)
    @balance += amount
  end

  def pay(amount)
    raise "Insufficient funds" unless has_sufficient_funds?(amount)
    @balance -= amount
  end
end 

class Match
  attr_reader :id, :home, :away, :odds, :status

  def initialize(id:, home:, away:, odds:, status: "open")
    @id = id
    @home = home
    @away = away
    @odds = odds
    @status = status
  end

  def open?
    @status == "open"
  end

  def odds_for(selection)
    key = selection.to_sym

    unless @odds.key?(key)
      raise ArgumentError, "Invalid selection #{selection}"
    end

    @odds[key]
  end

  def finish!
    @status = "finished"
  end
end

# Repositório em Memória (Agora com Objetos Reais!)
user1 = User.new(id: 1, name: "John Doe", email: "john@example.com", balance: 100.0)
match1 = Match.new(
  id: 101, 
  home: "Benfica", 
  away: "Porto", 
  odds: { home: 1.5, draw: 3.0, away: 2.2 }
)

$user_repo = { 1 => user1 }
$match_repo = { 101 => match1 }
$bets_repo = []

class BettingProcessor
  def process_bet(user_id, match_id, amount, bet_type, selection)
    user = $user_repo[user_id]
    match = $match_repo[match_id]

    return "User not found" if user.nil?
    return "Match not found" if match.nil?
    return "Match is closed" unless match.open? # Usa o método do objeto!

    return "Minimum bet is 5.0" if amount < 5.0

    # Primitive Obsession & Lógica Condicional Complexa
    if bet_type == "simple"
      # Cálculo de Odds hardcoded e acoplado
      begin
        odds = match.odds_for(selection)
      rescue ArgumentError => e
        return e.message
      end

      unless user.pay(amount) 
        return "Insufficient funds" 
      end
      
      bet_id = $bets_repo.size + 1
      new_bet = {
        id: bet_id,
        user_id: user_id,
        match_id: match_id,
        amount: amount,
        odds: odds,
        selection: selection,
        status: "pending",
        potential_win: amount * odds
      }
      $bets_repo << new_bet

      # Envio de email "Fake" acoplado
      puts "SENDING EMAIL TO #{user.email}: Bet placed on #{match.home} vs #{match.away} for #{amount} at odds #{odds}"
      
      return new_bet

    elsif bet_type == "live"
      # Imagine mais 50 linhas de lógica diferente aqui...
      return "Live betting not implemented yet"
    else
      return "Unknown bet type"
    end
  end

  # Método longo e com muitas responsabilidades
  def settle_match(match_id, result)
    match = $matches[match_id]
    match[:status] = "finished"
    
    $bets.each do |bet|
      if bet[:match_id] == match_id && bet[:status] == "pending"
        if bet[:selection] == result
          bet[:status] = "won"
          user = $users[bet[:user_id]]
          user[:balance] += bet[:potential_win]
          puts "EMAIL: You won #{bet[:potential_win]}!"
        else
          bet[:status] = "lost"
          puts "EMAIL: You lost your bet."
        end
      end
    end
  end
end