require 'spec_helper'

describe Group do
  let(:group) { Group.create!(name: "Our cool group!", jefe_id: 1) }
  let(:user) {User.create!(email: "test@test.com", password: "secure", first_name: "John", last_name: "Doe", current_location: "Chicago, IL")}


  it "should have name and jefe" do
    expect(group.name).to eq "Our cool group!"
    expect(group.jefe.first_name).to eq "John"
    expect(group.jefe_id).to eq user.id
  end

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
