class Users::SessionsController < Devise::SessionsController
  def destroy
    sign_out current_user
  end
end