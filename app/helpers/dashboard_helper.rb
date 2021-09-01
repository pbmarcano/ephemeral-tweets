module DashboardHelper
  def timeline_title_for(user)
    if user.sweeping?
      "Sweeping tweets"
    else
      "Not sweeping tweets"
    end
  end
end
