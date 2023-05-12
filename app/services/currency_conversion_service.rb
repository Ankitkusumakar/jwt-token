require 'rest-client'
class CurrencyConversionService
    def initialize(from_currency, to_currency, amount)
      @from_currency = from_currency
      @to_currency = to_currency
      @amount = amount
      eu_bank = EuCentralBank.new
      Money.default_bank = eu_bank
      eu_bank.update_rates
    end
  
    def convert
      Money.new(@amount*100, @from_currency).exchange_to(@to_currency).format
    end
  end
  