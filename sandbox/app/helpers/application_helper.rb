module ApplicationHelper
  def task_status_string(status)
    debugger
    I18n.t("activerecord.attributes.task.status.#{status}")
  end
end
