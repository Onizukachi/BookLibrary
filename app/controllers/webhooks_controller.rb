class WebhooksController < ApplicationController
  skip_forgery_protection

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = "whsec_338ba06f03442865b806f6461c273019ef6aa480e65e14a78da282c9ff0ae96c" # Rails.configuration.stripe[:webhook_secret]
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      status 400
      return
    end

    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      shipping_details = session["shipping_details"]
      address = "#{shipping_details["address"]["line1"]} #} #{shipping_details["address"]["city"]} #{shipping_details["address"]["state"]} #{shipping_details["address"]["postal_code"]}"
      order = Order.create!(email: session["customer_details"]["email"], total: session["amount_total"], address: address, fulfilled: false)
      full_session = Stripe::Checkout::Session.retrieve({
                                                          id: session.id,
                                                          expand: session['line_items']
                                                        })
      line_items = full_session.line_items
      line_items["data"].each do |line_item|
        product = Stripe::Product.retrieve(line_item["price"]["product"])
        product_id = product["metadata"]["product_id"].to_i
        OrderProduct.create!(order: order, product_id: product_id, quantity: item["quantity"], size: product["metadata"]["size"])
        Stock.find(product["metadata"]["stock_id"]).decrement!(:amount, item["quantity"])
      end
    else
      puts "Unhandled event type: #{event.type}"
    end

    render json: { message: "success" }
  end
end