require 'spec_helper'

describe Image do
  it "should belong_to a user" do
    user = User.create!
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
