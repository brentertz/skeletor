require 'spec_helper'

describe Admin::UsersController do
  let(:user) { create :user }

  before :each do
    login user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it "should render the index template" do
      get :index
      response.should render_template :index
    end

    it "assigns users" do
      create_list :user, 5
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should render the new template" do
      get :new
      response.should render_template :new
    end

    it "assigns a user" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, id: user.id
      response.should be_success
    end

    it "should render the edit template" do
      get :edit, id: user.id
      response.should render_template :edit
    end

    it "assigns a user" do
      get :edit, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET 'delete'" do
    it "should return http success" do
      get :delete, id: user.id
      response.should be_success
    end

    it "should render the delete template" do
      get :delete, id: user.id
      response.should render_template :delete
    end

    it "assigns a user" do
      get :delete, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST 'create'" do
    describe "valid" do
      it "should create a new user" do
        lambda {
          post :create, user: attributes_for(:user)
        }.should change(User, :count).by(1)
      end

      it "should redirect to users" do
        post :create, user: attributes_for(:user)
        response.should redirect_to admin_users_path
      end
    end

    describe "invalid" do
      it "should not create a new user" do
        lambda {
          post :create, user: {}
        }.should_not change(User, :count)
      end

      it "should rerender the new template" do
        post :create, user: {}
        response.should_not be_redirect
      end
    end
  end

  describe "PUT 'update'" do
    describe "valid" do
      it "should update an existing user" do
        user = create :user
        put :update, id: user.id, user: user.attributes.merge({ email: 'updated@email.tld' })
        user.reload.email.should == 'updated@email.tld'
      end

      it "should redirect to users" do
        user = create :user
        put :update, id: user.id, user: user.attributes.merge({ email: 'updated@email.tld' })
        response.should redirect_to admin_users_path
      end
    end

    describe "invalid" do
      it "should not update a user" do
        user = create :user
        put :update, id: user.id, user: user.attributes.merge({ email: nil })
        user.reload.email.should_not be_nil
      end

      it "should rerender the edit template" do
        user = create :user
        put :update, id: user.id, user: user.attributes.merge({ email: nil })
        response.should render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    describe "valid" do
      it "should delete user" do
        user = create :user
        lambda {
          delete :destroy, id: user.id
        }.should change(User, :count).by(-1)
      end
    end

    describe "invalid" do
      it "should not delete user" do
        user = create :user
        lambda {
          delete :destroy, id: -1
        }.should_not change(User, :count)
      end
    end
  end
end
