require 'spec_helper'

describe Admin::PagesController do
  let(:user) { create :user }

  describe "GET 'index'" do
    describe "Visitor" do
      it "should be denied access" do
        logout
        get 'index'
        response.should be_redirect
        response.should redirect_to root_url
      end
    end

    describe "Authenticated User" do
      it "should be granted access" do
        login user
        get 'index'
        response.should be_success
      end
    end
  end
end

