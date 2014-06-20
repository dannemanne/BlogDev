module ControllerHelpers

  def current_user
    @user ||= User.find @request.env['rack.session']['warden.user.user.key'][0][0]
  end

end
