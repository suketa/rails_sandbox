class MessagesController < ApplicationController
  def create
    debugger
    @message = Message.new(message_params)

    if @message.save
      render :create
    else
      render json: { status: 'error', errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.expect(message: [:content])
  end
end
