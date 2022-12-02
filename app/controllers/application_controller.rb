class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authorize_user!(model_or_record)
    action = "#{action_name}?".to_sym
    authorize(model_or_record, action)
  end

  private

  def user_not_authorized
    flash[:alert] = 'No tiene suficientes permisos para realizar esta operacion.'
    redirect_back(fallback_location: edit_user_path(current_user))
  end
end
