class CurrencyController < ApplicationController
  def convertor
      from_currency = params[:from]
      to_currency = params[:to]
      amount = params[:amount].to_f
  
      if from_currency && to_currency && amount
        begin
          result = CurrencyConversionService.new(from_currency, to_currency, amount).convert
          render json: { success: true, result: result }
        rescue Money::Currency::UnknownCurrency => e
          render json: { success: false, error: "Invalid currency code: #{e.currency}" }
        end
      else
        render json: { success: false, error: "Missing required parameters" }
      end
    end
end
