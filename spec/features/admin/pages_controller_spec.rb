require 'spec_helper'

describe Admin::PagesController do
  let(:user) { create :user }

  describe "Visitor" do
    it "should be denied access" do
      visit logout_path
      visit admin_path
      page.should have_content "Access Denied!"
    end
  end

  describe "Authenticated User" do
    it "should be granted access" do
      visit login_path
      fill_in "session_email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      page.should have_content "Welcome #{ user.email }"
    end
  end

end

