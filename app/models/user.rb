class User < ApplicationRecord
  after_save_commit :log_saved

  def log_saved
    Rails.logger.info("User(id = #{id}) #{name} is saved")
  end
end
