require 'spec_helper'

describe PostDecorator do
  let(:decorator) { post.decorate }
  subject { decorator }

  describe '#display_body' do
    let(:post) { FactoryBot.build(:post) }

    it { is_expected.to be_valid }

    context 'when :body is present but :parsed_body is missing' do
      before {
        post.body = "# Simple header\n\nAnd then a paragraph."
        post.parsed_body = nil
      }

      it 'parses the body and returns an html_safe string' do
        expect(decorator.display_body).to be_html_safe
        expect(decorator.display_body).to eq Kramdown::Document.new(post.body).to_html
      end
    end

    context 'when parsed_body has been set to override default parser' do
      let(:parsed_body) { "<h1 id=\"simple-header\" class=\"some extra css classes\">Simple Header</h1><p class=\"and classes here too\">And then a paragraph.</p>" }
      before {
        post.body = "# Simple header\n\nAnd then a paragraph."
        post.parsed_body = parsed_body
      }

      it 'returns the pre-parsed body' do
        expect(decorator.display_body).to be_html_safe
        expect(decorator.display_body).to eq parsed_body
        expect(decorator.display_body).not_to eq Kramdown::Document.new(post.body).to_html
      end
    end
  end
end
