json.array!(@votes) do |vote|
  json.extract! vote, :idea_id, :user_id
  json.url vote_url(vote, format: :json)
end
