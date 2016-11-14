class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def receipt_email(order)
    @order = order
    @url = 'http://example.com/orders'
    mail(to: @order.email, subject: 'Confirmation from Jungle for order number #{@order.id}!')
  end
end
