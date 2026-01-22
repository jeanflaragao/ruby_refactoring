class Bet
  attr_reader :id, :user_id, :match_id, :amount, :selection, :odds, :potential_win, :status

  STATUSES = ["pending", "won", "lost"].freeze

  def initialize(id:, user_id:, match_id:, amount:, bet_type:, selection:, odds:)
    @id = id
    @user_id = user_id
    @match_id = match_id
    @amount = amount
    @selection = selection
    @odds = odds
    @status = "pending"
    @potential_win = (amount * odds).round(2)
  end

  def win!
    @status = "won"
  end

  def lose!
    @status = "lost"
  end

  def pending?
    @status == "pending"
  end
end