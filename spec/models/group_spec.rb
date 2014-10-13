require 'spec_helper'

describe Group do
  let(:group) { Group.create!(name: "Our cool group!") }

  it "should be managed by a 'jefe'" do
    expect(group).to belong_to :jefe
  end

  it "should have many members" do
    expect(group).to have_many :members
  end

  it "should have many posts" do
    expect(group).to have_many :posts
  end

  it "should have many snippets" do
    expect(group).to have_many :snippets
  end

  it "should have an image" do
    expect(group).to have_one :image
  end
end
