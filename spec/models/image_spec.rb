require 'spec_helper'

describe Image do
  it "should belong_to a user" do
    user = User.new
      user.email = "isaac@gmail.com"
      user.password = "12345678"
      user.password_confirmation = "12345678"
      user.first_name = "Isaac"
      user.last_name = "Node.js"
      user.current_location = "Chicago, IL"
      user.save!
    image = Image.create!
    user.image = image
    expect(user.image.id).to eq image.id
  end

  it "should belong_to a group" do
    group = Group.create!
    image = Image.create!
    group.image = image
    expect(group.image).to eq image
  end
end
