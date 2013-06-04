require 'spec_helper'

describe User do
  describe "Validations" do
    subject { create :user }

    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe "authentication" do
    it "should generate auth_token on create" do
      user = build :user
      user.auth_token.should be_nil
      user.save
      user.auth_token.should_not be_nil
    end

    it "should authenticate with correct password" do
      user = create :user
      user.authenticate(user.password).should_not == false
    end

    it "should not authenticate with incorrect password" do
      user = create :user
      user.authenticate('incorrect').should == false
    end
  end
end
