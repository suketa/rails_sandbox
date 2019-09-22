class ApplicationController < ActionController::Base
  private

  def full_action_name
    "#{self.class.name}##{action_name}"
  end
end
