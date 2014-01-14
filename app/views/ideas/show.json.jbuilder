json.extract! @idea, :id, :title, :description, :topic_id, :user_id, :created_at, :updated_at

json.votes do
  json.total_vote_qty @idea.votes.count
  json.current_user_vote_id Vote.where({:user_id => @user.id, :idea_id => @idea.id}).pluck(:id).first
end
