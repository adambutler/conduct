json.extract! @topic, :title, :description, :locked, :user_id, :created_at, :updated_at, :secret

json.url topic_path(@topic)

json.ideas @topic.ideas do |idea|
  json.extract! idea, :title, :description, :topic_id, :user_id, :id
  json.created_at_in_words "#{ time_ago_in_words(idea.created_at) } ago"

  json.owner current_user.present? and (current_user.id == idea.user_id)
  
  json.url topic_idea_path(@topic, idea)

  json.votes do
    json.total_vote_qty idea.votes.count
    if current_user
      json.current_user_vote_id Vote.where({:user_id => current_user.id, :idea_id => idea.id}).pluck(:id).first
    end
  end
end
