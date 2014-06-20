require 'spec_helper'

describe CommentsController do
  render_views

  describe "DELETE 'destroy' for guests" do
    login_guest

    it 'should be able to delete their own comment' do
      post = FactoryGirl.create(:post, user: current_user)
      comment = FactoryGirl.create(:comment, post: post, user: current_user)

      delete 'destroy', id: comment.id
      expect(response).to be_redirect

      expect(Comment.find_by_id(comment.id)).to be_nil
    end

    it 'should NOT be able to delete another guests comment' do
      comment = FactoryGirl.create(:comment)
      expect(comment.user).not_to eq(current_user)

      delete 'destroy', id: comment.id
      expect(Comment.find_by_id(comment.id)).to be_present
    end

  end

  describe "DELETE 'destroy' for admins" do
    login_admin

    #it 'should always allow to delete comments' do
    #  user = Factory(:user)
    #  post = user.posts.create(Factory.attributes_for(:post))
    #  comment = post.comments.build(message: "Great post!")
    #  comment.user = user
    #  comment.save
    #  comment.should be_persisted
    #
    #  delete "destroy", id: comment.id
    #  response.should be_redirect
    #  Comment.find_by_id(comment.id).should be_nil
    #end

  end

end
