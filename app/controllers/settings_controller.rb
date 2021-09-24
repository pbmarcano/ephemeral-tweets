class SettingsController < ApplicationController
  before_action :set_settings

  def update
    if @setting.update(setting_params)
      ahoy.track "changed settings", @setting
      redirect_to dashboard_path, notice: "Success"
    else
      redirect_to dashboard_path, notice: "Fail"
    end
  end

  private

  def set_settings
    @setting = current_user.setting
  end

  def setting_params
    params.require(:setting).permit(:sweeping, :time_threshold)
  end
end
