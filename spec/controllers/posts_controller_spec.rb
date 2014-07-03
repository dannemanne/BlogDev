require 'spec_helper'

describe PostsController do
  render_views

  describe "GET 'new' for admins" do
    login_admin

    it 'should show form to add new post when user is admin' do
      expect(current_user.role).to eq(User::ROLE_ADMIN)

      get 'new'
      expect(response).to be_success
    end
  end

  describe "POST 'create' for admins" do
    login_admin

    it 'should create a new Post' do
      attr = { title: 'New Post', body: 'This is the post body', status: Post::STATUS_POSTED, tag_names: 'Tag-Name' }
      expect(current_user.role).to eq(User::ROLE_ADMIN)
      count = current_user.posts.count

      post 'create', post: attr
      expect(response).to be_redirect
      expect(current_user.posts(true).count).to eq(count+1)
    end
  end

end
