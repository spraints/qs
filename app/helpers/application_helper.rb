module ApplicationHelper
  def timestamp(time)
    time.strftime("%Y-%m-%d %H:%M")
  end
end
