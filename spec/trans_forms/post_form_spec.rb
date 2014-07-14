require 'spec_helper'

describe PostForm do
  let(:user) { FactoryGirl.create(:admin) }
  it 'validates presence of current_user' do
    form = PostForm.new_in_model(Post.new, {}, user)
    expect(form.valid?).to be true

    form.current_user = nil
    expect(form.valid?).to be false
  end
  it 'creates/adds Tags based on tag_names upon save' do
    attr = { title: 'Post Title', body: 'Lorem Ipsum', tag_names: 'Foo, Bar', status: PostStatus::DRAFT, current_user: user }
    form = PostForm.new_in_model(Post.new, attr, user)

    expect(form.save).to be true
    expect(form.post.tags).to be_any
  end
end
