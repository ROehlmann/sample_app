FactoryGirl.define do
  factory :user do 	# tells FG that info is for a User model object.
  	sequence(:name)  { |n| "Person #{n}" }
  	sequence(:email) { |n| "person_#{n}@example.com" }
  	password "foobar"
  	password_confirmation	"foobar"
  	# This definitions allows us to create a User factory in the tests
  	# with let(:user) { FactoryGirl.create(:user) }

  	factory :admin do
  	  admin true		# FactoryGirl.create(:admin)
  	end
  end
end
