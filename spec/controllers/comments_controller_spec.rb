require 'spec_helper'

describe CommentsController do

  describe "DELETE 'destroy' for guests" do
    login_guest

    it "should be able to delete their own comment" do
      post = current_user.posts.create(Factory.attributes_for(:post))
      comment = post.comments.build(message: "Great post!")
      comment.user = current_user
      comment.save
      comment.should be_persisted

      delete "destroy", id: comment.id
      response.should be_redirect
      Comment.find_by_id(comment.id).should be_nil
    end

    it "should NOT be able to delete another guests comment" do
      user = Factory(:user)
      post = user.posts.create(Factory.attributes_for(:post))
      comment = post.comments.build(message: "Great post!")
      comment.user = user
      comment.save
      comment.should be_persisted

      delete "destroy", id: comment.id
      Comment.find_by_id(comment.id).should be_present
    end

  end

  describe "DELETE 'destroy' for admins" do
    login_admin

    it "should always allow to delete comments" do
      user = Factory(:user)
      post = user.posts.create(Factory.attributes_for(:post))
      comment = post.comments.build(message: "Great post!")
      comment.user = user
      comment.save
      comment.should be_persisted

      delete "destroy", id: comment.id
      response.should be_redirect
      Comment.find_by_id(comment.id).should be_nil
    end

  end

end
