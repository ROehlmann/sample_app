FactoryGirl.define do
  factory :user do 	# tells FG that info is for a User model object.
  	name		"Michael Hartl"
  	email		"michael@example.com"
  	password	"foobar"
  	password_confirmation	"foobar"
  	# This definitions allows us to create a User factory in the tests
  	# with let(:user) { FactoryGirl.create(:user) }
  end
end
