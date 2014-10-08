require 'spec_helper'


describe Comment do
  let(:comment) {Comment.new}

  it "belongs to a creator" do
  	expect(comment).to belong_to :creator
	end


	it "belongs to a snippet" do
    snippet = Snippet.create!
    comment = Comment.create!
    snippet.comments << comment
    expect(snippet.comments.first).to eq comment
	end

	it "belongs to a post" do
    post = Post.create!
    comment = Comment.create!
    post.comments << comment
    expect(post.comments.first).to eq comment
	end

	it "should have a database column called 'content'" do
		expect(comment).to have_db_column :content
	end

end