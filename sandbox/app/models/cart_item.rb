class CartItem < ApplicationRecord
  belongs_to :product
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :list, -> { includes(:product).order(:id) }

  class << self
    def build_to_append(params)
      cart_item = find_by(product_id: params[:product_id])
      if cart_item
        cart_item.quantity += params[:quantity].to_i
      else
        cart_item = CartItem.new(params)
      end
      cart_item
    end

    def total_price
      all.sum(&:total_item_price)
    end
  end

  def total_item_price
    product.price * quantity
  end
end
