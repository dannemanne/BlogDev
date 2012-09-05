module PostsHelper

  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render("comment", comment: comment) + content_tag(:div, nested_comments(sub_comments), class: "nested_messages")
    end.join.html_safe
  end

  def comment_header(comment)
    name = comment.name.blank? ? "Guest" : comment.name
    website = comment.user.present? ? comment.user.website : comment.website
    ((website.present? ? link_to(h(name), website) : h(name)) +
        content_tag(:span, comment.created_at.strftime("%a, %Y-%m-%d %H:%M"))).html_safe
  end

end
