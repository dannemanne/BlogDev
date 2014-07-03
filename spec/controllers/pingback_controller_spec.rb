require 'spec_helper'

describe PingbackController do
  describe "POST 'xmlrpc'" do
    it 'creates a linkback record' do
      pending 'Pingback::Server is not working in RSpec env...'
      count = Linkback.count

      post 'xmlrpc'

      expect(Linkback.count).to eq(count+1)
    end
  end
end
