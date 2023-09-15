class Avo::ToolsController < Avo::ApplicationController
  before_action :pre_process_settings_params, only: [:update_settings]
  def settings
    add_breadcrumb "Settings"
  end

  def update_settings
    User.find(@settings_params[:user_id]).update! settings: @settings_params.except(:user_id).to_h

    redirect_to main_app.settings_path
  end

  private 

  def pre_process_settings_params
    @settings_params = params.require(:settings).permit(:user_id, :tutorial)

    @settings_params[:tutorial] = ActiveModel::Type::Boolean.new.cast(@settings_params[:tutorial])
  end
end
