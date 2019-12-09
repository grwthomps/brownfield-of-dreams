require 'rails_helper'

describe "As a logged in User" do
  before(:each) do
    VCR.use_cassette('adding_friends') do
      user = create(:user, github_token: ENV["Github_access_token"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

  context "I see a button only next to Gituhub followers who are also Brownsfield users" do
    it "I can add friend" do
      within "#follower-0" do
        expect(page).to have_button "Add Friend"
      end
      within "#follower-1" do
        expect(page).to have_link
      end
      within "#follower-2" do
        expect(page).to have_link
      end

    end

    it "cannot add friend of follower who is not a Brownsfield user" do

    end
  end
end

describe "As a logged in User" do
  context "I see a button only next to a Gituhub user I am following who is also a Brownsfield users" do
    it "I can add friend" do

    end

    it "cannot add friend of someone I am following who is not a Brownsfield user" do

    end
    end 
  end
end
