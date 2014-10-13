require "spec_helper"

describe "Group" do 

	before :each do
    User.create!(email: "test@test.com", password: "12345678", first_name: "John", last_name: "Doe", current_location: "Chicago, IL")
    visit root_path
    click_link ("Sign In")
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => '12345678'
    first('input[type="submit"]').click
	end

	it "displays nothing when no posts or snippets are present." do
		group = Group.create!(name: "Our cool group!", jefe_id: 1)
		visit "/groups/#{group.id}"
		expect(page).to have_content("Our cool group!")
		expect(page).not_to have_content("Snippet")
	end

	it "displays posts when posts are present." do
    user = User.create!(email: "test1@test.com", password: "12345678", first_name: "John", last_name: "Doe", current_location: "Chicago, IL")
		post = Post.create!(title: "On Putting Dogs to Sleep", content: "Why should know you're doing whatever")
		group = Group.create!(name: "Our cool group!", jefe_id: 1)
		user.posts << post
		group.posts << post
		visit "/groups/#{group.id}"
		expect(page).to have_content("On Putting Dogs to Sleep")
		expect(page).not_to have_content("Snippet")
	end

	it "displays snippets when snippets are present" do
		snippet = Snippet.create(content: "Cause im already in mine / Ain't about my heart is everything is done / I believe in the credits / It's the 7 things flowing up.", creator_id: 1, group_id: 1)
		group = Group.create!(name: "Our cool group!", jefe_id: 1)
		group.snippets << snippet
		visit "/groups/#{group.id}"
		expect(page).to have_content("Snippet")
	end

	it "displays snippets and posts when snippets and posts are present" do
		group = Group.create!(name: "Our cool group!", jefe_id: 1)
    user = User.create!(email: "test1@test.com", password: "12345678", first_name: "John", last_name: "Doe", current_location: "Chicago, IL")
		snippet = Snippet.create(content: "Cause im already in mine / Ain't about my heart is everything is done / I believe in the credits / It's the 7 things flowing up.", creator_id: 1, group_id: 1)
		post = Post.create(creator_id: 1, title: "On Putting Dogs to Sleep", content: "Why should know you're doing whatever")
		user.posts << post
		user.snippets << snippet
		group.posts << post
		group.snippets << snippet
		visit "/groups/#{group.id}"
		expect(page).to have_content("On Putting Dogs to Sleep")
		expect(page).to have_content("Snippet")
	end


end