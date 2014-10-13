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

  it "should have a membership to a group" do
    expect(user).to have_many :memberships
  end

  it "should be jefe of many groups" do
    expect(user).to have_many :managed_groups
  end

  it "should be a regular member of many groups" do
    expect(user).to have_many :groups
  end

  it "should have many posts" do
    expect(user).to have_many :posts
  end

  it "should have many snippets" do
    expect(user).to have_many :snippets
  end

  it "should have many comments" do
    expect(user).to have_many :comments
  end

  it "should not store plain text password" do
    expect(user.password.to_s).to eq user.password_digest.to_s
  end

end