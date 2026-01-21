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