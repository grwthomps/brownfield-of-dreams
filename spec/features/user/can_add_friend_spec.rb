require 'rails_helper'

describe "As a logged in User" do
  before(:each) do
    VCR.use_cassette('adding_friends') do
      user = create(:user, github_username: "grwthomps", github_token: ENV["Github_access_token"])
      friend = create(:user, github_token: ENV["friend_access_token"], github_username: "tyladevon")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end
  end

  context "I see a button only next to Gituhub followers who are also Brownsfield users" do
    it "I can add friend" do
      within "#follower-0" do
        expect(page).to have_button "Add Friend"
      end
      within "#follower-1" do
        expect(page).to_not have_button "Add Friend"
      end
    end
  end

  context "I see a button only next to a Gituhub user I am following who is also a Brownsfield users" do
    it "I can add friend" do
      within "#follow-1" do
        expect(page).to have_button "Add Friend"
      end
      within "#follow-0" do
        expect(page).to_not have_button "Add Friend"
      end
    end
  end
end
