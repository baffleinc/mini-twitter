require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_page_title('Sample App') }
    it { should have_page_title(full_title('')) }
    it { should_not have_page_title('| Home') }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Gooby Pls")
        FactoryGirl.create(:micropost, user: user, content: "DOLAN GO AWAY")
        sign_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
      
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end
        
        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
      
      describe "should render micropost count for user" do
        it { should have_selector('.micropost-count', text: "microposts") }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_page_heading('Help') }
    it { should have_page_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_page_heading('About') }
    it { should have_page_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_page_heading('Contact') }
    it { should have_page_title(full_title('Contact')) }
  end
  
  it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      page.should { have_page_title(full_title('About Us')) }
      click_link "Help"
      page.should { have_page_title(full_title('Help')) }
      click_link "Contact"
      page.should { have_page_title(full_title('Contact')) }
      click_link "Home"
      click_link "Sign Up Now!"
      page.should { have_page_title(full_title('Sign Up')) }
      click_link "sample app"
      page.should { have_page_title(full_title('')) }
    end
end