class CheckoutsController < ApplicationController
  def create
    cart = params[:cart]

    line_items = cart.map do |item|
      product = Product.find(item["id"])
      stock = product.stocks.find { |stock| stock.size == item["size"] }

      if stock.amount < item["quantity"].to_i
        render json: { error: "Not enough stock for #{product.name} in size #{stock.size}. Only #{stock.amount} left!" }, status: 400
        return
      end

      {
        quantity: item["quantity"].to_i,
        price_data: {
          product_data: {
            name: item["name"],
            metadata: { product_id: product.id, size: item["size"], stock_id: stock.id },
          },
          currency: "usd",
          unit_amount: item["price"].to_i
        }
      }
    end

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: line_items,
      success_url: "http://localhost:3000/success",
      cancel_url: "http://localhost:3000/cancel",
      shipping_address_collection: {
        allowed_countries: ["US", "CA"],
      }
    )

    render json:  { url: session.url }
  end
end