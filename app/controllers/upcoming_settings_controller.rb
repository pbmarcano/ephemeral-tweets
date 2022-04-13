class UpcomingSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_settings

  def update
    if @settings.update(setting_params)
      redirect_to upcoming_path, notice: "Success"
    else
      redirect_to upcoming_path, notice: "Fail"
    end
  end

  private

  def set_settings
    @settings = current_user.setting
  end

  def setting_params
    params.require(:setting).permit(:upcoming_notification)
  end
end
