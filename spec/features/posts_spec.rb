# encoding: utf-8
require 'spec_helper'

describe 'posts' do

  describe 'edit' do
    before do
      login(:admin)
    end

    let(:post) { FactoryBot.create(:post) }

    it 'should succeed' do
      visit post_path(post)
      click_link 'Edit'

      fill_in 'Body', :with => 'This is some new content'
      click_button 'Save'

      #page.should have_no_content('2014-10-02')
      expect( post.reload.body ).to eq 'This is some new content'
    end
  end

end
