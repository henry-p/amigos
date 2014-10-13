require 'spec_helper'

describe Post do
  it "should belong to one user" do
    user = User.create!
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
