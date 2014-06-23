require 'spec_helper'

describe DraftsController do
  render_views

  describe "GET 'index' for admins" do
    login_admin

    let(:user_draft) { FactoryGirl.create(:draft, user: current_user) }
    it 'should list the Users Posts that is still drafted' do
      expect(user_draft.user).to eq(current_user)

      get 'index'
      expect(response).to be_success
    end
    it 'should still work when there are no Drafts present' do
      expect(current_user.posts.drafts).to be_empty

      get 'index'
      expect(response).to be_success
    end
  end

end
