class Notifier < ActionMailer::ARMailer
  def new_comment_notification(comment)
    blog_owner = comment.entry.user
    recipients blog_owner.email_with_username
    
    from       "VersionCoders <system@versioncoders.net>"
    subject    "A new comment has been left on your blog"
    body       :comment => comment,
               :blog_owner=> blog_owner,
               :blog_owner_url => "http://localhost:3000/users/#{blog_owner.id}",
               :blog_entry_url =>"http://localhost:3000/users/#{blog_owner.id}/entries/#{comment.entry.id}"
    content_type "text/html"
  end
  def newsletter(user,newsletter)
    recipients user.email
    from       "RailsCoders <system@Versioncoders.net>"
    subject    newsletter.subject
    body       :body => newsletter.body, :user => user
  end
  
end
