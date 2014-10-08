require 'spec_helper'

describe Membership do
  it "should belong to a user" do
    expect(Membership.new).to belong_to :user
  end

  it "should belong to a group" do
    expect(Membership.new).to belong_to :group
  end
end
