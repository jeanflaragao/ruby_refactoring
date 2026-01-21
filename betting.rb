# database_mock.rb - Simulando um banco de dados global (primeiro erro!)
$users = {
  1 => { name: "John Doe", balance: 100.0, email: "john@example.com" }
}

$matches = {
  101 => { home: "Benfica", away: "Porto", odds: { home: 1.5, draw: 3.0, away: 2.2 }, status: "open" }
}

$bets = []

class BettingProcessor
  def process_bet(user_id, match_id, amount, bet_type, selection)
    user = $users[user_id]
    match = $matches[match_id]

    # Validações misturadas com lógica
    if user.nil?
      return "User not found"
    end

    if match.nil?
      return "Match not found"
    end

    if match[:status] != "open"
      return "Match is closed"
    end

    if user[:balance] < amount
      return "Insufficient funds"
    end

    # Primitive Obsession & Lógica Condicional Complexa
    if bet_type == "simple"
      if amount < 5.0
        return "Minimum bet is 5.0"
      end

      # Cálculo de Odds hardcoded e acoplado
      odds = 0
      if selection == "home"
        odds = match[:odds][:home]
      elsif selection == "draw"
        odds = match[:odds][:draw]
      elsif selection == "away"
        odds = match[:odds][:away]
      else
        return "Invalid selection"
      end

      # Atualização de estado direta (Side Effects)
      user[:balance] = user[:balance] - amount
      
      bet_id = $bets.size + 1
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
      $bets << new_bet

      # Envio de email "Fake" acoplado
      puts "SENDING EMAIL TO #{user[:email]}: Bet placed on #{match[:home]} vs #{match[:away]}"
      
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