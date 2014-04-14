require 'spec_helper'

describe User do
  
  # The following code gets run before each example.
  before { @user = User.new(name: "Example User", email: "user@example.com") }

  # Makes @user the default subject of the test example.
  subject { @user }
  
  # It is a convention to test for all model attributes. Doing this also
  # conveniently creates a list of the methods all User objects should respond to.
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  # Tests if the element fullfills all the requirements specified in models/user.rb
  it { should be_valid }

  describe "when name is not present" do
  	before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  
  # DANGER! Uniqueness needs to be validated at DB level as well!
  # (by creating a DB index and requiring it to be unique)
  # And require the email attribute to be all lower-case before trying to save it.
  describe "when email address is already taken" do
    before do
      # Save user with the same attributes as @user to the DB so there exists
      # already a matching user in the DB when evaluating the uniqueness of @user.
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase # To make it case-insensitive.
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
end



