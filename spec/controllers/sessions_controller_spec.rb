require 'spec_helper'

describe SessionsController do
  let(:user) { create :user, password: 'password', password_confirmation: 'password' }

  describe "GET 'new'" do
    it "should render the new session template" do
      get :new
      response.should be_success
      response.should render_template('sessions/new')
    end
  end

  describe "POST 'create'" do
    describe "invalid user" do
      it "should NOT create a session for an invalid user" do
        logout
        post :create, session: { email: user.email, password: 'invalid_password' }
        response.should render_template('sessions/new')
        flash[:alert].should == "Email or password invalid"
      end
    end

    describe "valid user" do
      it "should create a new session for a valid user" do
        logout
        post :create, session: { email: user.email, password: 'password' }
        response.should redirect_to admin_url
        flash[:notice].should == "You are now logged in"
        cookies[:auth_token].should == user.auth_token
      end

      describe "remember me" do
        #it "should set a permanent cookie if checked" do
          #pending "Determine how to use permanent cookies in Capybara"
          #logout
          #post :create, session: { email: user.email, password: 'invalid_password', remember_me: true }
          #cookies.permanent[:auth_token].should == user.auth_token
        #end

        it "should set a regular cookie if unchecked" do
          logout
          post :create, session: { email: user.email, password: 'password' }
          #cookies.permanent.should_not include :auth_token
          cookies[:auth_token].should == user.auth_token
        end
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should log a user out" do
      login user
      delete :destroy, { id: 'current' }
      response.should redirect_to root_url
      flash[:notice].should == 'You are now logged out'
      cookies.should_not include :auth_token
    end
  end

end
