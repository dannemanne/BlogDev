require 'spec_helper'

describe PostForm do
  let(:user) { FactoryGirl.create(:admin) }
  let(:attr) { {} }
  let(:form) { PostForm.new(attr) }

  it { expect(form).to be_an_instance_of PostForm }

  describe 'validations' do
    let(:post) { FactoryGirl.create(:post) }
    let(:form) { PostForm.new_in_model(post, attr, user) }

    subject { form.valid? }

    it { is_expected.to eq true }

    context 'when +current_user+ is missing' do
      before { form.current_user = nil }

      it { is_expected.not_to eq true }
    end
  end

  describe '#save' do
    let(:post) { FactoryGirl.create(:post) }
    let(:form) { PostForm.new_in_model(post, attr, user) }

    subject { form.save }

    context 'when +tag_names+ are present' do
      let(:attr) { { title: 'Post Title', body: 'Lorem Ipsum', tag_names: 'Foo, Bar', status: PostStatus::DRAFT } }

      it 'creates two new tags' do
        expect{ form.save }.to change{ Tag.count }.by(2)
      end

      it 'associates the tags with the post' do
        form.save
        expect(form.post.tags.count).to eq 2
      end
    end
  end
end
