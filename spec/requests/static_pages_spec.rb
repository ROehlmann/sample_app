require 'spec_helper'

describe "Static Pages" do

  subject { page }
  # Tells all tests inside "Static Pages" to look at the page as object of
  # testing. 'expect(page)' is no longer needed. 

  describe "Home Page" do
    before { visit root_path }
    # Tells all tests inside "Home Page" to go to the root path before looking
    # at the object of the test. It is no longer necessary to add
    # 'visit root_path' before every single test.
    
    it { should have_content('Sample App') }
  	it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help Page" do
    before { visit help_path }
    
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About Page" do
    before { visit about_path }

    it { should have_content('About Us') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact Page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
