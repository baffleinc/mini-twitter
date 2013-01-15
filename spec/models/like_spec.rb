require 'spec_helper'

describe Like do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:micropost) { FactoryGirl.create(:micropost) }
  let(:like){ user.like!(micropost) }
  
  subject { like }
  
  it { should be_valid }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:micropost_id) }
  
  describe "like methods" do
    it { should respond_to(:user) }
    its(:user) { should == user }
    it { should respond_to(:micropost) }
    its(:micropost) { should == micropost }
    
    describe "when user_id is not present" do
      before { like.user_id = nil }
      it { should_not be_valid } 
    end
    
    describe "when micropost_id is not present" do
      before { like.micropost_id = nil }
      it { should_not be_valid } 
    end
  end
end
