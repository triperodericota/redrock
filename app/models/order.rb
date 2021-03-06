class Order < ApplicationRecord

  belongs_to :product
  belongs_to :fan
  belongs_to :buyer
  belongs_to :address, optional: true
  has_one :payment

  validates_associated :product, :fan, :buyer
  validates :units, presence: true, length: { maximum: 10 }, numericality: { only_integer: true , greater_than_or_equal_to: 1 }
  validates :total_price, presence: true, length: { maximum: 10 }, numericality: { greater_than_or_equal_to: 0 }
  validates_inclusion_of :delivery, in: [true, false]

  before_validation do |order|
    order.total_price= (order.product.price * order.units)
  end

  before_create do |order|
    if self.delivery
      self.class.validates_associated :address
    end
  end

  def payment_status
    unless self.payment.nil?
      return self.payment.status
    else
      "desconocido"
    end
  end

  def create_checkout_with()
    preferenceData = {
        "items": [ self.product.hash_data_for_order(self.units) ],
        "payer": self.buyer.hash_data_for_order,
        "auto_return": "approved",
        "back_urls": {
            "success": "http://localhost:3000/register_pay",
            "failure": "http://localhost:3000/register_pay",
            "pending": "http://localhost:3000/register_pay"
        },
        "binary_mode": true,
        "statement_descriptor": "RedRock"
    }
    add_address_data_to(preferenceData) if self.delivery
    preference = $mp.create_preference(preferenceData)
    self.preference_id = preference["response"]["id"]
    self.save
    preference
  end

  def status_css_style
    unless self.payment.nil?
      if self.payment.approved?
        return 'badge-success'
      elsif self.payment.rejected?
        'badge-danger'
      elsif self.payment.pending?
        return 'badge-warning'
      end
    else
      return 'badge badge-secondary'
    end
  end


  protected

  def add_address_data_to(data_hash)
    self.address.hash_data_for_order(data_hash)
  end

end
