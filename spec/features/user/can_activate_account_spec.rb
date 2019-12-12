require 'rails_helper'

describe 'As a logged in user' do
  it 'I can activate my account' do
    user = create(:user, status: 'inactive')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(user.status).to eq('inactive')

    visit "/activate/#{user.id}"

    expect(current_path).to eq(dashboard_path)

    visit dashboard_path
    user.reload

    expect(user.status).to eq('active')
  end

  it 'I cannot activate account with invalid id' do
    user = create(:user, status: 'inactive')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(user.status).to eq('inactive')

    visit "/activate/23593"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Whoops, something went wrong. Please try to activate again.")

    user.reload
    expect(user.status).to eq('inactive')
  end
end
