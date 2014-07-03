require 'spec_helper'

describe PostsController do
  render_views
  let(:blog_post) { FactoryGirl.create(:post) }

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

  describe "POST 'comment'" do
    it 'should add a Comment when commenting is allowed' do
      attr = { name: 'John Doe', message: 'Great Post', website: 'http://my.web.com' }
      expect(blog_post.allow_comments).to eq(true)
      count = blog_post.comments.count

      post 'comment', id: blog_post.to_param, comment: attr
      expect(response).to be_redirect
      expect(blog_post.comments(true).count).to eq(count+1)
    end

    it 'should not add a Comment when spam is detected' do
      attr = { name: 'John Doe', message: 'Great Post', website: 'http://my.web.com', website_url: 'not blank value' }
      expect(blog_post.allow_comments).to eq(true)
      count = blog_post.comments.count

      post 'comment', id: blog_post.to_param, comment: attr
      expect(response).to be_redirect
      expect(blog_post.comments(true).count).to eq(count)
    end
  end

end
