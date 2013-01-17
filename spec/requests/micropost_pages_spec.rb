require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:micropost) { FactoryGirl.create(:micropost, user: user) }
  before { sign_in user }

  describe "single micropost page" do
    before { visit micropost_path(micropost) }
    it { should have_selector('p', text: micropost.content) }

    describe "like/unlike buttons" do
      it { should have_selector('input', value: 'Like') }
      let(:like) { "Like" }

      describe "liking a micropost" do
        it "should increment the posts's likes" do
          expect { click_button like }.to change(micropost.likes, :count).by(1)
        end
      end

      describe "toggle the button" do
        before { click_button like }
        it { should have_selector('input', value: "Unlike") }
      end

      describe "unliking a micropost" do
        before do
          user.like!(micropost)
          visit micropost_path(micropost)
        end

        let(:unlike) { "Unlike" }

        it "should decrement the posts's likes" do
          expect { click_button unlike }.to change(micropost.likes, :count).by(-1)
        end

        describe "toggle the button" do
          before { click_button unlike }
          it { should have_selector('input', value: "Like") }
        end
      end

      describe "should show a list of users that liked the post" do
        before do
          click_button like
          click_link "likes"
        end

        it { should have_selector('li', text: user.name) }
      end
    end
  end

  describe "micropost creation" do
    before { visit root_path }
    let(:post) { "Post" }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button post }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button post }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
end