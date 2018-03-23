class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    cookies[:user_id] = current_user.try(:id) || 'guest' 
    super
  end

  # GET /resource/sign_out
  def destroy
    super
  end
end
