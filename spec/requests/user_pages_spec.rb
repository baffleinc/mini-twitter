require 'spec_helper'
 
describe "UserPages" do

  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_page_heading('Sign up') }
    it { should have_page_title(full_title('Sign Up')) }
    #it { should have_selector('title', text: full_title('Sign Up')) }
  end
  
  describe "signup" do
  
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        before { click_button submit }
        
        it { should have_page_title('Sign Up') }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }
        
        it { should have_page_title(user.name) }
        it { should have_success_message("Welcome") }
        it { should have_link('Sign out') }
      end
    end
  end
  
  describe "profile page" do
  
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_page_heading(user.name) }
    it { should have_page_title(user.name) }
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    #before { visit edit_user_path(user) }
    let(:submit) { "Save changes" }
    
    describe "page" do
      it { should have_page_heading("Update your profile") }
      it { should have_page_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    
      describe "with invalid information" do
        before { click_button submit }
        
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button submit
      end
      
      it { should have_page_title(new_name) }
      it { should have_success_message("") }
      it { should have_link('Sign out', href: signout_path) }
      
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
    
  end
end
