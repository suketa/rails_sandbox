class CartItem < ApplicationRecord
  belongs_to :product
  validates :quantity, presence: true, numericality: { only_integer: true }
  validate :validate_quantity

  attribute :new_quantity, :integer, default: 0

  scope :list, -> { includes(:product).order(:id) }

  class << self
    def build_to_append(params)
      cart_item = find_or_initialize_by(product_id: params[:product_id])
      cart_item.quantity += params[:quantity].to_i
      cart_item.new_quantity = params[:quantity].to_i
      cart_item
    end

    def total_price
      all.sum(&:total_item_price)
    end
  end

  def update(params)
    self.new_quantity = params[:quantity].to_i
    super(params)
  end

  def total_item_price
    product.price * quantity
  end

  private

  def validate_quantity
    Rails.logger.info("🍎#{quantity.inspect} 🍊#{new_quantity.inspect}")
    if quantity.to_i <= 0 || new_quantity.to_i <= 0
      errors.add(:quantity, "must be greater than 0")
    end
  end
end
