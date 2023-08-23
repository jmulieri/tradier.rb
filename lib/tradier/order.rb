require 'tradier/base'

module Tradier
  class Order < Tradier::Base
    attr_reader :id, :order_id, :type, :price, :symbol, :side, :quantity, \
    :status, :time_in_force, :option_type, :exec_inst, :exec_status, :extended_hours, \
    :trailing_limit_type, :trailing_stop_type, :request_date, :response_date, :num_legs, \
    :errors, :result, :stop_price, :duration, :avg_fill_price, :exec_quantity, :last_fill_price, \
     :last_fill_quantity, :remaining_quantity, :create_date, :transaction_date, :strategy, :option_symbol

    class Leg < Tradier::Base
      attr_reader :id, :type, :symbol, :side, :quantity, :status, :duration, :price, \
      :avg_fill_price, :exec_quantity, :last_fill_price, :last_fill_quantity, :remaining_quantity, \
      :create_date, :transaction_date, :option_symbol

      def leg_class
        attrs[:class]
      end
    end

    def self.from_response(body={})
      new(body[:order] || body)
    end

    def order_class
      attrs[:class]
    end

    def legs
      Array(attrs[:leg]).map { |l| Leg.new(l) }
    end
  end
end
