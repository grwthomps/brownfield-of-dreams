require 'rails_helper'

describe "As a Visitor" do
  before(:each) do
    @tutorial = create(:tutorial, classroom: true)
    @tutorial_2 = create(:tutorial, classroom: false)
  end

  it "cannot see classroom tutorials on the Welcome Page" do
    visit '/'

    expect(page).to_not have_content(@tutorial.description)
    expect(page).to_not have_content(@tutorial.title)

    expect(page).to have_content(@tutorial_2.description)
    expect(page).to have_content(@tutorial_2.title)
  end
  it "cannot see classroom tutorials on the Tutorials page" do
    visit '/tutorials'

    expect(page).to_not have_content(@tutorial.description)
    expect(page).to_not have_content(@tutorial.title)

    expect(page).to have_content(@tutorial_2.description)
    expect(page).to have_content(@tutorial_2.title)
  end
  it "cannot see classroom tutorials on the Tutorials Show page" do
    visit "/tutorials/#{@tutorial.id}"

    expect(current_path).to eq('/')
    expect(page).to have_content("Please log in to see this content")
  end

end
