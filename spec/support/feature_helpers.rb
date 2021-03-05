include Warden::Test::Helpers

module FeatureHelpers
  def login(factory = :user)
    user = FactoryBot.create(factory)
    login_as user, scope: :user
    user
  end
end
