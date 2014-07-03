require 'spec_helper'

describe Post do
  let(:post) { FactoryGirl.build(:post) }
  describe 'validations' do
    it 'validates title presence' do
      expect(post).to be_valid

      post.title = ''
      expect(post).to be_invalid
    end
    it 'validates body presence' do
      expect(post).to be_valid

      post.body = ''
      expect(post).to be_invalid
    end
  end

  describe 'assignments' do
    it 'assigns title_url based on title before validation' do
      expect(post.title).to be_present
      expect(post.title_url).to be_blank

      post.valid?
      expect(post.title_url).to be_present
    end
    it 'creates/adds Tags based on tag_names upon save' do
      expect(post.tags).to be_empty

      post.tag_names = 'Tag'
      expect(post.save).to eq(true)
      expect(post.tags(true)).to be_any
    end
  end
end
