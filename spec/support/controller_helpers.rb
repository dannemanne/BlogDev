module ControllerHelpers

  def current_user
    if (key = @request.env['rack.session']['warden.user.user.key']).present?
      @user ||= User.find key[0][0]
    end
  end

end
