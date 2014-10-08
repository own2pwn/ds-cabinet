class Order< ActiveRecord::Base

  belongs_to :orderable, polymorphic: true

  delegate :integration_id, :offering_id, :offering_price_id, :offering_url,
    :promocode, :paid_and_not_expired?, :to => :orderable

  delegate :order_id, :url, :status, :update_status, :to => :cart_order

  serialize :cart_order, Ds::Purchase::Order

  after_create :create_cart_order

  def post success_url, error_url
    cart_order.post(integration_id, 
                      [[offering_id, offering_price_id, offering_url, promocode]],
                      success_url, 
                      error_url)
    self.save
  end

  def paid? 
    !!payment_date
  end
  
  def update_status
    cart_order.update_status
    update_column(:payment_date, cart_order.last_edited_time) if cart_order.paid?
  end

  protected

  def create_cart_order
    self.cart_order= Ds::Purchase::Order.new
  end
end
