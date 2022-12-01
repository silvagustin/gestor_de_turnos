class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'No tiene suficientes permisos para realizar esta operacion.'
    redirect_back(fallback_location: edit_user_path(current_user))
  end
end
