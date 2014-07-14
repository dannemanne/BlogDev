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

  describe "GET 'index'" do
    it 'should list the posts' do
      expect(blog_post.status).to eq(PostStatus::POSTED)

      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'archive'" do
    it 'should list the posts for that month' do
      expect(blog_post.status).to eq(PostStatus::POSTED)

      get 'archive', year: blog_post.posted_at.strftime('%Y'), month: blog_post.posted_at.strftime('%m')
      expect(response).to be_success
    end
  end

  describe "POST 'create' for admins" do
    login_admin

    it 'should create a new Post' do
      attr = { title: 'New Post', body: 'This is the post body', status: PostStatus::POSTED, tag_names: 'Tag-Name' }
      expect(current_user.role).to eq(User::ROLE_ADMIN)
      count = current_user.posts.count

      post 'create', post: attr
      expect(response.redirect?).to be true
      expect(current_user.posts(true).count).to eq(count+1)
    end
  end

  describe "GET 'show'" do
    let(:post_with_comments) { FactoryGirl.create(:post_with_comments) }
    describe 'for guests' do
      it 'can show a post with comments' do
        expect(post_with_comments.comments).not_to be_empty

        get 'show', id: post_with_comments.to_param
        expect(response).to be_success
      end
    end

    describe 'for admins' do
      login_admin

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
