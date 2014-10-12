class GroupMailer < ActionMailer::Base
  default from: "no-reply@friendzone.com"

  def self.group_snippet_notifications(group)
    members = group.members
    members.each do |member|
      single_snippet_notification(member, group).deliver
    end
  end

  def self.group_post_notifications(group, post)
    members = group.members
    members.each do |member|
      single_post_notification(member, group, post).deliver
    end
  end


  def single_snippet_notification(member, group)
    @member = member
    @group = group
    mail(to: @member.email, subject: "Someone from #{@group.name} created a new snippet.")
  end


  def single_post_notification(member, group, post)
    @member = member
    @group = group
    @post = post
    mail(to: @member.email, subject: "Someone from #{@group.name} created a new post.")
  end
end
