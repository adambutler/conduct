json.extract! @topic, :title, :description, :locked, :user_id, :created_at, :updated_at, :secret

json.ideas @topic.ideas do |idea|
  json.extract! idea, :title, :description, :topic_id, :user_id
  json.created_at_in_words "#{ time_ago_in_words(idea.created_at) } ago"
  json.votes do
    json.total_vote_qty idea.votes.count
    json.current_user_vote_id Vote.where({:user_id => current_user.id, :idea_id => idea.id}).pluck(:id).first
  end
end
