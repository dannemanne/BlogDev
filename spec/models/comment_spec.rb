require 'spec_helper'

describe Comment do
  let(:comment) { FactoryGirl.build(:comment) }
  it 'validates message presence' do
    expect(comment).to be_valid

    comment.message = ''
    expect(comment).to be_invalid
  end
  it 'validates that message is not longer than 512 characters' do
    expect(comment).to be_valid

    comment.message = (1..513).inject { |acc,n| "#{acc}a" }
    expect(comment).to be_invalid

    comment.message = (1..512).inject { |acc,n| "#{acc}a" }
    expect(comment).to be_valid
  end
end
