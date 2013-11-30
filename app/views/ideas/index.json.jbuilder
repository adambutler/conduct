json.array!(@ideas) do |idea|
  json.extract! idea, :title, :description, :topic_id, :user_id
  json.url idea_url(idea, format: :json)

  json.votes do
    json.total_vote_qty idea.votes.count
    json.current_user_vote_id Vote.where({:user_id => current_user.id, :idea_id => idea.id}).pluck(:id).first
  end
end
