module TurboStreamActionsHelper
  def set_title_counter(count, divider: nil)
    turbo_stream_action_tag :set_title_counter, count: count, divider: divider
  end
end

Turbo::Streams::TagBuilder.prepend TurboStreamActionsHelper
