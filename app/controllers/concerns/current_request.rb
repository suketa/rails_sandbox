module CurrentRequest
  extend ActiveSupport::Concern
  included do
    before_action do
      Current.user_agent = request.user_agent
    end
  end
end
