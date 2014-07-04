require 'spec_helper'

describe DraftsController do
  render_views
  let(:user_draft) { FactoryGirl.create(:draft, user: current_user) }

  describe "GET 'index' for admins" do
    login_admin

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

  describe "PUT 'update' for admins" do
    login_admin

    it 'should update an existing draft' do
      attr = { title: 'Updated Post', body: 'This is the updated post body', status: PostStatus::POSTED, tag_names: 'Tag-Name' }
      expect(current_user.role).to eq(User::ROLE_ADMIN)
      expect(user_draft.user).to eq(current_user)
      expect(user_draft.status).to eq(PostStatus::DRAFT)

      put 'update', id: user_draft.to_param, post: attr
      expect(response).to be_redirect
      expect(user_draft.reload.body).to eq(attr[:body])
    end
  end

  describe "DELETE 'destroy'" do
    describe 'for admins' do
      login_admin

      it 'should delete a post that has status draft' do
        expect(current_user.role).to eq(User::ROLE_ADMIN)
        expect(user_draft.user).to eq(current_user)
        expect(user_draft.status).to eq(PostStatus::DRAFT)

        delete 'destroy', id: user_draft.to_param
        expect(response).to be_redirect
        expect(Post.find_by_id(user_draft.id)).to be_nil
      end
    end

    describe 'for guests' do
      let(:other_draft) { FactoryGirl.create(:draft) }
      it 'should NOT delete a post' do
        expect(current_user).to be_nil
        expect(other_draft.status).to eq(PostStatus::DRAFT)

        delete 'destroy', id: other_draft.to_param
        expect(response).to be_redirect # redirect to root path
        expect(Post.find_by_id(other_draft.id)).to be_present
      end
    end
  end

end
