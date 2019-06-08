class FruitsController < ApplicationController
  FRUITS = %w[grapes melon watermelon tangerine lemon].freeze
  GRAPES = 0x1f347

  def show
    i = params[:id].to_i
    filename = [GRAPES + i].pack('U*') + '.txt'
    send_data FRUITS[i], filename: filename
  end
end
