require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user)
    #@user = {
      #name: "Example User",
      #email: "user@example.com",
      #password: "foobar",
      #password_confirmation: "foobar"
    #}
  end
  it "should create a new instance given valid attributes" do
    @user
    #User.create!(@user)
  end
  it "should require a name" do
    no_user_name = @user.name = ""
    no_user_name.should_not be_valid
  end
  it "should require a email" do
    no_user_name = User.new(@user.merge(email: ""))
    no_user_name.should_not be_valid
  end
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_user_name = User.new(@user.merge(name: long_name))
    long_user_name.should_not be_valid
  end
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@user.merge(email: address))
      valid_email_user.should be_valid
    end
  end
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com THE_USER_at_foo.bar.org first.last@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@user.merge(email: address))
      invalid_email_user.should_not be_valid
    end
  end
  it "should reject duplicate email addresses" do
    User.create!(@user)
    user_with_duplicate_email = User.new(@user)
    user_with_duplicate_email.should_not be_valid
  end
  it "should reject email addresses identical up to case" do
    upcased_email = @user[:email].upcase
    User.create!(@user.merge(email: upcased_email))
    user_with_duplicate_email = User.new(@user)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@user.merge(password: "", password_confirmation: "")).
        should_not be_valid
    end
    it "should require a matching password confirmation" do
      User.new(@user.merge(password_confirmation: "invalid")).
        should_not be_valid
    end
    it "should reject short passwords" do
      short = "a" * 5
      hash = @user.merge(password: short, password_confirmation: short)
      User.new(hash).should_not be_valid
    end
    it "should reject long passwords" do
      long = "a" * 41
      hash = @user.merge(password: long, password_confirmation: long)
      User.new(hash).should_not be_valid
    end
  end
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@user)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    it "should et the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@user[:password]).should be_true
      end
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@user[:email], "wrongpass")
        wrong_password_user.should be_nil
      end
      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @user[:password])
        nonexistent_user.should be_nil
      end
      it "should return nil on email/password mismatch" do
        matching_user = User.authenticate(@user[:email], @user[:password])
        matching_user.should == @user
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

