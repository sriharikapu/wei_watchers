class BalanceCheck

  def initialize(account)
    @account = account
  end

  def perform
    if current_balance != past_balance
      account.update_attributes! balance: current_balance

      account.notify_subscribers({
        address: account.address,
        current_balance: current_balance.to_s,
        difference: (past_balance - current_balance).to_s,
        past_balance: past_balance.to_s,
      })
    end
  end


  private

  attr_reader :account

  def current_balance
    @current_balance ||= account.current_balance
  end

  def past_balance
    @past_balance ||= account.balance
  end

end