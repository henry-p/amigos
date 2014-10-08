require 'spec_helper'

describe User do
  let(:user) {User.create!(email: "test@test.com", password: "secure", first_name: "John", last_name: "Doe", current_location: "Chicago, IL")}

  it "should have email, password_digest, first_name, last_name, current_location and an image_id" do
    image = double('image', class: Image, user_id: user.id)
    
    expect(user.email).to eq "test@test.com"
    expect(user.password_digest).not_to be_nil
    expect(user.password_digest).not_to be "secure"
    expect(user.first_name).to eq "John"
    expect(user.last_name).to eq "Doe"
    expect(user.current_location).to eq "Chicago, IL"
    expect(image.user_id).to eq user.id
  end

  it "should have a single profile picture" do
    expect(user).to have_one :image
  end
end