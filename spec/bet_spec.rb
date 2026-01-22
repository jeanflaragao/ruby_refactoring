require_relative '../betting'

RSpec.describe Bet do
  # Setup: Criamos uma aposta padrão para usar nos testes
  # Usamos let(:bet) que é "lazy" (só cria quando chamado)
  let(:bet) do
    Bet.new(
      id: 1,
      user_id: 99,
      match_id: 101,
      amount: 10.0,
      selection: "home",
      odds: 1.5
    )
  end

  describe "#initialize" do
    it "starts with 'pending' status" do
      expect(bet.status).to eq("pending")
      expect(bet.pending?).to be true
    end

    it "calculates potential_win correctly" do
      # 10.0 * 1.5 = 15.0
      expect(bet.potential_win).to eq(15.0)
    end
  end

  describe "#win!" do
    it "changes status to 'won'" do
      # Ação
      bet.win!
      
      # Verificação
      expect(bet.status).to eq("won")
      expect(bet.pending?).to be false
    end
  end

  describe "#lose!" do
    it "changes status to 'lost'" do
      bet.lose!
      expect(bet.status).to eq("lost")
    end
  end
end