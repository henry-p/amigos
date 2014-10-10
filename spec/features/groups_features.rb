desribe "Group" do 

	before :each do
		Group.create!(name: "Our cool group!", jefe_id: 1)
    User.create!(email: "test@test.com", password: "secure", first_name: "John", last_name: "Doe", current_location: "Chicago, IL")
    visit '/sessions/new'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => 'secure'
    first('input[type="submit"]').click
	end

	it "displays nothing when no posts or snippets are present." do
		visit '/groups/1'
		expect.page.to have_content("Our cool group!")
		expect.page.not_to have_content("Snippet")
	end

	it "displays posts when posts are present." do
		Post.create(group_id: 1, creator_id: 1, title: "On Putting Dogs to Sleep", content: "Why should know you're doing whatever")
		visit '/groups/1'
		expect.page.to have_content("On Putting Dogs to Sleep")
		expect.page.not_to have_content("Snippet")
	end

	it "displays snippets when snippets are present" do
		Snippet.create(content: "Cause im already in mine / Ain't about my heart is everything is done / I believe in the credits / It's the 7 things flowing up.", creator_id: 1, group_id: 1)
		visit '/groups/1'
		expect.page.to have_content("Snippet")
	end

	it "displays snippets and posts when snippets and posts are present" do
		Post.create(group_id: 1, creator_id: 1, title: "On Putting Dogs to Sleep", content: "Why should know you're doing whatever")
		Snippet.create(content: "Cause im already in mine / Ain't about my heart is everything is done / I believe in the credits / It's the 7 things flowing up.", creator_id: 1, group_id: 1)
		visit '/groups/1'
		expect.page.to have_content("On Putting Dogs to Sleep")
		expect.page.to have_content("Snippet")
	end


end