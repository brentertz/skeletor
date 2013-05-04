require 'spec_helper'

describe "Sessions" do
  let(:user) { create :user }

  before :each do
    visit logout_path
  end

  describe "invalid credentials" do
    it "should not be authenticated" do
      visit login_path
      fill_in "session_email", with: user.email
      fill_in "Password", with: "invalid_password"
      click_button "Log In"
      page.should have_content "Email or password invalid"
    end
  end

  describe "valid credentials" do
    it "should be authenticated" do
      visit login_path
      fill_in "session_email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      page.should have_content "You are now logged in"
    end

    #describe "remember me" do
      #it "should set a permanent cookie if checked" do
        #pending "Determine how to use permanent cookies in Capybara"
        #visit login_path
        #fill_in "session_email", with: user.email
        #fill_in "Password", with: user.password
        #click_button "Log In"
        #cookies.permanent[:auth_token].should == user.auth_token
      #end

      #it "should set a regular cookie if unchecked" do
        #pending "Determine how to use cookies in Capybara"
        #visit login_path
        #fill_in "session_email", with: user.email
        #fill_in "Password", with: user.password
        #click_button "Log In"
        #cookies.permanent.should_not include :auth_token
        #cookies[:auth_token].should == user.auth_token
      #end
    #end
  end

end
