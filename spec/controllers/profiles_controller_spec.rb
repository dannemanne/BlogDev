require 'spec_helper'

describe ProfilesController do
  render_views

  describe "GET 'show'" do
    describe 'when user is logged in' do
      login_admin

      it 'should be success' do
        expect( current_user ).to be_present

        get 'show'
        expect( response ).to be_success
      end
    end

    describe 'when no user is logged in' do
      it 'should be access denied' do
        expect( current_user ).to be_nil

        get 'show'
        expect( response ).to be_redirect
      end
    end
  end

  describe "GET 'edit'" do
    describe 'when user is logged in' do
      login_admin

      it 'should be success' do
        expect( current_user ).to be_present

        get 'edit'
        expect( response ).to be_success
      end
    end

    describe 'when no user is logged in' do
      it 'should be access denied' do
        expect( current_user ).to be_nil

        get 'edit'
        expect( response ).to be_redirect
      end
    end
  end

end
