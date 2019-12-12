require 'rails_helper'

describe 'As a logged in user', :vcr do

  it 'I see a link to invite a Github user on my dashboard' do
    user = create(:user, github_token: ENV['Github_access_token'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on 'Invite a Github friend!'

    expect(current_path).to eq('/invite')

    fill_in "Github handle", with: "not-zorro"

    click_on "Send Invite"

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content("Successfully sent invite!")
  end

  it "cannot send an invite to a non-Github user" do
    user = create(:user, github_token: ENV['Github_access_token'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on 'Invite a Github friend!'

    expect(current_path).to eq('/invite')

    fill_in "Github handle", with: "blahblah"

    click_on "Send Invite"

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
