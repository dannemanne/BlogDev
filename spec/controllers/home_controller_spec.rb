require 'spec_helper'

describe HomeController do
  render_views
  let(:blog_post) { FactoryGirl.create(:post) }

  describe "GET 'index'" do
    it 'should list the posts' do
      expect(blog_post.status).to eq(PostStatus::POSTED)

      get 'index'
      expect(response).to be_successful
    end
  end

  describe "GET 'acme_challenge'" do
    context 'when challenge is incorrect' do
      it 'responds with :not_found' do
        with_modified_env ACME_CHALLENGE: '123', ACME_SECRET: 'ABC' do
          get 'acme_challenge', params: { challenge: '456' }
          expect(response).to have_http_status :not_found
        end
      end
    end

    context 'when challenge is correct' do
      it 'responds with acme_secret' do
        with_modified_env ACME_CHALLENGE: '123', ACME_SECRET: 'ABC' do
          get 'acme_challenge', params: { challenge: '123' }
          expect(response).to have_http_status :ok
          expect(response.body).to eq 'ABC'
        end
      end
    end
  end

end
