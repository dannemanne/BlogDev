include Warden::Test::Helpers

module FeatureHelpers
  def login(factory = :user)
    user = FactoryGirl.create(factory)
    login_as user, scope: :user
    user
  end
end
