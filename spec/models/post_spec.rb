require 'spec_helper'

describe Post do
  it "should belong to one user" do
    user = User.new
      user.email = "isaac@gmail.com"
      user.password = "12345678"
      user.password_confirmation = "12345678"
      user.first_name = "Isaac"
      user.last_name = "Node.js"
      user.current_location = "Chicago, IL"
      user.save!
    post = Post.create!
    user.posts << post
    expect(post).to belong_to :creator
  end

  it "should belong to one group" do
    group = Group.create!
    post = Post.create!
    group.posts << post
    expect(post).to belong_to :group
  end
end
