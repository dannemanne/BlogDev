module ControllerHelpers

  def current_user
    if (key = @request.env['rack.session']['warden.user.user.key']).present?
      @user ||= User.find key[0][0]
    end
  end

  def with_modified_env(options, &block)
    ClimateControl.modify(options, &block)
  end

end
