module ControllerMacros

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
    end
  end

  def login_guest
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in Factory.create(:user)
    end
  end

end
