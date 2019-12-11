require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it "I see bookmarks organized by tutorial on User Dashboard" do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    tutorial_2 = create(:tutorial)
    video_2 = create(:video, tutorial_id: tutorial_2.id)
    video_3 = create(:video, tutorial_id: tutorial_2.id)

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    visit tutorial_path(tutorial_2)

    click_on 'Bookmark'

    click_on "#{video_3.title}"

    click_on 'Bookmark'

    visit ('/dashboard')

    within "#Bookmarks" do
      within(first("#tutorial")) do
        expect(page).to have_content(tutorial.title)
      end
      within "#tutorial")) do
        expect(page).to have_content(tutorial_2.title)
      end
    end
  end
end
