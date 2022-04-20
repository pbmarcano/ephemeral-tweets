module UpcomingHelper
  def deletion_day(days_until_deletion)
    case days_until_deletion
    when 0 then "Sometime today"
    when 1 then "Tomorrow"
    else
      days_until_deletion.days.from_now.strftime("%A, %B %e")
    end
  end
end
