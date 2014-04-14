require 'spec_helper'

describe "Static Pages" do

  subject { page }
  # Tells all tests inside "Static Pages" to look at the page as object of
  # testing. 'expect(page)' is no longer needed.

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end
  # Creates shared examples that can be tested using
  # 'it_shouls_behave_like "name_of_shared_examples_group"' with the required
  # local variables defined using 'let' in the respective "description". 

  describe "Home Page" do
    before { visit root_path }
    # Tells all tests inside "Home Page" to go to the root path before looking
    # at the object of the test. It is no longer necessary to add
    # 'visit root_path' before every single test.
    
    let(:heading)     { 'Sample App' }
  	let(:page_title)  { '' }
    # Definition of the local variables required for the shared examples.

    it_should_behave_like "all static pages"
    # Call of the shared examples test.
    it { should_not have_title('| Home') }
  end

  describe "Help Page" do
    before { visit help_path }
    
    let(:heading)     { 'Help' }
    let(:page_title)  { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About Page" do
    before { visit about_path }

    let(:heading)     { 'About Us' }
    let(:page_title)  { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact Page" do
    before { visit contact_path }

    let(:heading)     { 'Contact' }
    let(:page_title)  { 'Contact' }

    it_should_behave_like "all static pages"
  end

   it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "Sample App"
    expect(page).to have_title(full_title(''))
  end
end
