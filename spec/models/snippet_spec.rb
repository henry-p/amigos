require 'spec_helper'

describe Snippet do

	let(:snippet) {Snippet.new(content: "My new snippet")}

	it "belongs to a user" do
	  expect(snippet).to belong_to :creator
	end

	it "belongs to a group" do
	  expect(snippet).to belong_to :group
	end

	it "has a content database column" do
	  expect(snippet).to have_db_column :content
	end
end
