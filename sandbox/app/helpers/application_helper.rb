module ApplicationHelper
  def task_status_string(status)
    Task.human_attribute_name("status.#{status}")
  end

  def task_status_options
    Task.statuses.map do |status, _|
      [task_status_string(status), status]
    end
  end
end
