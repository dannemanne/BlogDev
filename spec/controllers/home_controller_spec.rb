require 'spec_helper'

describe HomeController do
  render_views
  let(:blog_post) { FactoryGirl.create(:post) }

  describe "GET 'index'" do
    it 'should list the posts' do
      expect(blog_post.status).to eq(PostStatus::POSTED)

      get 'index'
      expect(response).to be_success
    end
  end

end
