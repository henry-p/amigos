user = User.new
user.email = "cwshevlin@gmail.com"
user.password = "12345678"
user.password_confirmation = "12345678"
user.first_name = "Colin"
user.last_name = "Shevlin"
user.current_location = "Chicago, IL"
user.save!

user = User.new
user.email = "henry.perschk@gmail.com"
user.password = "12345678"
user.password_confirmation = "12345678"
user.first_name = "Henry"
user.last_name = "Perschk"
user.current_location = "Chicago, IL"
user.save!

user = User.new
user.email = "nixonlr@gmail.com"
user.password = "12345678"
user.password_confirmation = "12345678"
user.first_name = "Nixon"
user.last_name = "Da Bozz"
user.current_location = "Chicago, IL"
user.save!

user = User.new
user.email = "ndunetts@gmail.com"
user.password = "12345678"
user.password_confirmation = "12345678"
user.first_name = "Sir"
user.last_name = "Nigelton"
user.current_location = "Chicago, IL"
user.save!

Group.create(name: "DBC4eva", jefe_id: 2)

Membership.create(member_id: 1, group_id: 1)
Membership.create(member_id: 2, group_id: 1)
Membership.create(member_id: 3, group_id: 1)
Membership.create(member_id: 4, group_id: 1)

Post.create(group_id: 1, creator_id: 3, title: "On Putting Dogs to Sleep", content: "Why should know you're doing whatever,
That you I did before,
And the world small world,
Your games you're happy wherever you more than that means.

It's really over- please don't hear your eyes I,
I will stay on the sun,
I'm doing fine,
I'm so you ever say is.

[chorus]
You know what we were,
The words in the line in time.
You know what we were,
The words in the line in time.")

Snippet.create(content: "Cause im already in mine / Ain't about my heart is everything is done / I believe in the credits / It's the 7 things flowing up.", creator_id: 1, group_id: 1)

Snippet.create(content: "Li-li / I can't be tamed you / I'm lazy / And I look somewhere else falls into this kicking.",creator_id: 4, group_id: 1)

Post.create(group_id: 1, creator_id: 3, title: "Some More of My Poetry", content: "I care of something stops me see you lose,
Drive my brain ma,
Boom de clap de clap de,
I care of the world.

Don't know your hands up,
When you love me back with you there,
That you up the story's getting old,
So tragic.

[chorus]
This kicking and yes dear we're gonna,
'cause what we up you alone.
This kicking and yes dear we're gonna,
'cause what we up you alone.")

Comment.create(content: "Wow Torey you're really good at poetry", creator_id: 2, commentable_id: 1, commentable_type: "Post")
Comment.create(content: "This vacation is doing you some good!", creator_id: 1, commentable_id: 1, commentable_type: "Post")
Comment.create(content: "lol", creator_id: 3, commentable_id: 1, commentable_type: "Snippet")
Comment.create(content: "Wait is this a Miley song?", creator_id: 4, commentable_id: 2, commentable_type: "Post")

