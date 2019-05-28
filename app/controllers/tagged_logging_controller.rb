class TaggedLoggingController < ApplicationController
  def index
    logger0 = Logger.new(Rails.root.join('log', Rails.env + '.log'))
    logger1 = ActiveSupport::TaggedLogging.new(logger0)
    logger2 = ActiveSupport::TaggedLogging.new(logger1)
    logger1.tagged('TAG1') do
      logger2.tagged('TAG2') do
        logger0.info("log by logger0(id = #{logger0.__id__})")
        logger1.info("log by logger1(id = #{logger1.__id__})")
        logger2.info("log by logger2(id = #{logger2.__id__})")
      end
    end
  end
end
