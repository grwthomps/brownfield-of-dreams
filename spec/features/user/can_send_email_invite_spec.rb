require 'rails_helper'

describe 'As a logged in user' do
  it 'I see a link to invite a Github user on my dashboard' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_button 'Send Invite'

    expect(current_path).to eq('/invite')
  end

  it ''
end
