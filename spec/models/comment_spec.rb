require 'spec_helper'

describe Comment do
  it "cannot have a message that is longer than 255 characters" do
    comment = Comment.new
    comment.message = (1..256).inject { |acc,n| "#{acc}a" }
    comment.should_not be_valid
    comment.errors_on(:message).should be_present

    comment.message = (1..255).inject { |acc,n| "#{acc}a" }
    comment.valid?
    comment.errors_on(:message).should_not be_present
  end
end
