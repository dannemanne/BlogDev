require 'spec_helper'

describe PostsController do
  render_views
  let(:blog_post) { FactoryGirl.create(:post) }

  describe "GET 'new' for admins" do
    login_admin

    it 'should show form to add new post when user is admin' do
      expect(current_user.role).to eq(User::ROLE_ADMIN)

      get 'new'
      expect(response).to be_successful
    end
  end

  describe "GET 'index'" do
    it 'should list the posts' do
      expect(blog_post.status).to eq(PostStatus::POSTED)

      get 'index'
      expect(response).to be_successful
    end
    it 'should list all the latest posts' do
      10.times { FactoryGirl.create(:post) }

      get 'index'
      expect(response).to be_successful
    end
    it 'should be able to show multiple pages of posts' do
      10.times { FactoryGirl.create(:post) }

      expect(Post.count).to be > PostsController::POSTS_PER_PAGE

      get 'index', params: { page: 2 }
      expect(response).to be_successful
    end
  end

  describe "GET 'archive'" do
    it 'should list the posts for that month' do
      expect(blog_post.status).to eq(PostStatus::POSTED)

      get 'archive', params: { year: blog_post.posted_at.strftime('%Y'), month: blog_post.posted_at.strftime('%m') }
      expect(response).to be_successful
    end
  end

  describe "POST 'create' for admins" do
    login_admin

    it 'should create a new Post' do
      attr = { title: 'New Post', body: 'This is the post body', status: PostStatus::POSTED, tag_names: 'Tag-Name' }
      expect(current_user.role).to eq(User::ROLE_ADMIN)
      count = current_user.posts.count

      post 'create', params: { post: attr }
      expect(response.redirect?).to be true
      expect(current_user.posts.count).to eq(count+1)
    end
  end

  describe "GET 'show'" do
    let(:post) { FactoryGirl.create(:post) }
    describe 'for guests' do
      it 'can show a post' do
        get 'show', params: { id: post.to_param }
        expect(response).to be_successful
      end
    end

    describe 'for admins' do
      login_admin

    end
  end

  describe "PUT 'update' for admins" do
    login_admin
    let(:user_post) { FactoryGirl.create(:post, user: current_user) }
    it 'should create a new Post' do
      attr = { title: 'Updated Title', body: 'Body is now updated', status: PostStatus::POSTED, tag_names: 'Altered-Tag, And-Another' }
      expect(current_user.role).to eq(User::ROLE_ADMIN)
      expect(user_post.user).to eq current_user

      put 'update', params: { id: user_post.to_param, post: attr }
      expect(response.redirect?).to be true
      expect(user_post.reload.title).to eq attr[:title]
      expect(user_post.body).to eq attr[:body]
      expect(user_post.status).to eq attr[:status]
    end
  end

end
