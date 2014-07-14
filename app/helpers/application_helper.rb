module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(dt)
    dt.strftime("on %m/%d/%Y at %l:%M%P %Z")
  end
end
