require 'spec_helper'

describe Post do
  subject { post }

  describe 'validations' do
    let(:post) { FactoryBot.build(:post) }

    it { is_expected.to be_valid }

    context 'when :title is missing' do
      before { post.title = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when :body is missing' do
      before { post.body = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when :parsed_body is missing' do
      before { post.parsed_body = nil }

      it { is_expected.to be_valid }
    end
  end

  describe '#save' do
    let(:post) { FactoryBot.build(:post) }

    context 'when creating a new post' do
      before { post.title = 'A very good post' }

      it 'assigns title_url based on title upon save' do
        expect { post.save }.to change{ post.title_url }.to('a_very_good_post')
      end
    end
  end
end
