json.array!(@ideas) do |idea|
  json.extract! idea, :id, :title, :description, :topic_id, :user_id
  json.url topic_idea_url(@topic, idea, format: :json)

  json.votes do
    json.total_vote_qty idea.votes.count
    json.current_user_vote_id Vote.where({:user_id => @user.id, :idea_id => idea.id}).pluck(:id).first
  end
end
