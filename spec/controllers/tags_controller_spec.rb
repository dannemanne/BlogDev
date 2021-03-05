require 'spec_helper'

describe TagsController do
  render_views

  describe "GET 'index'" do
    context 'when there are no tags' do
      it 'should list the tags' do
        get 'index'
        expect(response).to render_template :index
      end
    end

    context 'when there are tags present' do
      before { FactoryBot.create_list(:tag, 3) }

      it 'should list the tags' do
        get 'index'
        expect(response).to render_template :index
      end
    end
  end

  describe "GET 'show'" do
    let(:tag) { FactoryBot.create(:tag) }

    describe 'for guests' do
      context 'when Tag has no posts' do
        it 'shows an empty page' do
          get 'show', params: { id: tag.to_param }
          expect(response).to render_template :show
        end
      end

      context 'when Tag has posts' do
        before { FactoryBot.create(:post_tag, tag: tag) }

        it 'shows an empty page' do
          get 'show', params: { id: tag.to_param }
          expect(response).to render_template :show
        end
      end
    end

    describe 'for admins' do
      login_admin

    end
  end

end
