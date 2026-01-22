require_relative '../betting'

RSpec.describe User do
  # 'subject' é o objeto que estamos a testar. Criamos um novo para cada teste.
  subject(:user) { User.new(id: 1, name: "Test User", email: "test@example.com", balance: 100.0) }

  describe "#pay" do
    context "when user has sufficient funds" do
      it "deducts the amount from balance" do
        # Expectation (O que esperamos)
        expect { user.pay(10.0) }.to change { user.balance }.from(100.0).to(90.0)
      end

      it "returns true" do
        expect(user.pay(10.0)).to be true
      end
    end

    context "when user has INSUFFICIENT funds" do
      it "does not change the balance" do
        # Tenta pagar 200 tendo apenas 100
        expect { user.pay(200.0) }.not_to change { user.balance }
      end

      it "returns false" do
        expect(user.pay(200.0)).to be false
      end
    end
  end
end