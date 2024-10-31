class CartItem < ApplicationRecord
  belongs_to :product
  validates :quantity, presence: true, numericality: { only_integer: true }
  validate :validate_quantity

  scope :list, -> { includes(:product).order(:id) }

  class << self
    def build_to_append(params)
      cart_item = find_or_initialize_by(product_id: params[:product_id])
      cart_item.quantity += params[:quantity].to_i
      cart_item
    end

    def total_price
      all.sum(&:total_item_price)
    end
  end

  def total_item_price
    product.price * quantity
  end

  private

  def validate_quantity
    _current, new = self.quantity_change_to_be_saved
    if new.nil? || new <= 0
      errors.add(:quantity, "must be greater than 0")
    end
  end
end
