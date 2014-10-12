class GroupMailer < ActionMailer::Base
  default from: "no-reply@friendzone.com"

  def self.send_group_snippet_notifications(group)
	  members = group.members
    members.each do |member|
      send_snippet_notification(member, group)
    end
  end

   def self.send_group_post_notifications(group)
	  members = group.members
    members.each do |member|
      send_post_notification(member, group)
    end
  end


  def send_snippet_notification(member, group)
  	@member = member
  	@group = group
  	mail(to: @member.email, subject: "Someone from #{group.name} created a new snippet.")
  end


  def send_post_notification(member, group)
  	@member = member
  	@group = group
  	mail(to: @member.email, subject: "Someone from #{group.name} created a new post.")
  end
end
